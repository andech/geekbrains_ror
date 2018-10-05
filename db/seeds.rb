# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Mark.destroy_all
Comment.destroy_all
Post.destroy_all
User.destroy_all
Seo.destroy_all

hash_users = 10.times.map do 
  {
    name: FFaker::Internet.user_name[0..16],
    email: FFaker::Internet.safe_email
  }
end
users = User.create! hash_users
users.first(7).each { |u| u.update creator: true }
users.first(2).each { |u| u.update moderator: true }

creators = User.where(creator: true)
hash_posts = 20.times.map do
  {
    title: FFaker::HipsterIpsum.phrase,
    body: FFaker::HipsterIpsum.paragraph(20),
    user: creators.sample
  }
end
posts = Post.create! hash_posts

hash_comments = 1000.times.map do
  commentable = ((rand(2) == 1) ? posts : users).sample
  {
    body: FFaker::HipsterIpsum.paragraph,
    user: users.sample,
    commentable_id: commentable.id,
    commentable_type: commentable.class.to_s
  }
end
Comment.create! hash_comments

hash_marks = 400.times.map do
  {
    user: users.sample,
    post: posts.sample,
    value: rand(1..5)
  }
end
Mark.create! hash_marks

def make_hash_seos(entity)
  hash_seos = entity.count.times.map do |i|
    {
      keywords: FFaker::HipsterIpsum.phrase,
      description: FFaker::HipsterIpsum.phrase,
      title: FFaker::HipsterIpsum.phrase,
      seoable_id: entity.offset(i).limit(1).ids[0],
      seoable_type: entity.to_s
    }
  end
  Seo.create! hash_seos
end

make_hash_seos(Post)
make_hash_seos(User)