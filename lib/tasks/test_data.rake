namespace :test do
    desc "Fill db with test data"
    task test_data: :environment do

        Rake::Task['db:reset'].invoke

        5.times do
            user = User.create({
                :name => Faker::Name.first_name,
                :email => Faker::Internet.email,
                :moderator => rand(2) == 1,
                :creator => rand(2) == 1,
                :banned => rand(2) == 1
            })
            user.save!
        end

        5.times do
            post = Post.create({
                :title => Faker::Lorem.sentence(3, true, 5),
                :body => Faker::Lorem.sentence(50, true, 20),
                :user => User.all.ids.sample,
                :visible => rand(2) == 1
            })
            post.save!
        end

        5.times do
            comment = Comment.create({
                :body => Faker::Lorem.sentence(3, true, 10),
                :user => User.all.ids.sample,
                :post => Post.all.ids.sample,
                :visible => rand(2) == 1
            })
            comment.save!
        end
        
    end
end
