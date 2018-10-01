namespace :development do
    desc "Fill db with test data"
    task test_data: :environment do

        Rake::Task['db:reset'].invoke

        5.times do
            user = User.create({
                name: FFaker::Name.first_name,
                email: FFaker::Internet.email,
                moderator: rand(2) == 1,
                creator: rand(2) == 1,
                banned: rand(2) == 1
            })
            user.save!
        end

        5.times do
            post = Post.create({
                title: FFaker::Lorem.word,
                body: FFaker::Lorem.phrases,
                user: User.all.sample,
                visible: rand(2) == 1
            })
            post.save!
        end

        5.times do
            comment = Comment.create({
                body: FFaker::Lorem.phrases,
                user: User.all.sample,
                post: Post.all.sample,
                visible: rand(2) == 1
            })
            comment.save!
        end

        5.times do
            mark = Mark.create({
                value: rand(1..5),
                user: User.all.sample,
                post: Post.all.sample
            })
            mark.save!
        end
        
    end
end
