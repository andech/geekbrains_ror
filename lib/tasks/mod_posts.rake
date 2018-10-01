namespace :test do
  desc 'Show moderator\'s posts'
  task mod_posts: :environment do
    ap Post.joins(:user).where(users: {moderator: true})
  end
end