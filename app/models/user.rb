class User < ApplicationRecord
    before_destroy :log_before_destroy
    after_destroy :log_after_destroy

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :commented_posts, through: :comments, source: :commentable, source_type: :Post
    has_many :commented_users, through: :comments, source: :commentable, source_type: :User
    has_many :marks, dependent: :destroy
    has_one :seo, as: :seoable, dependent: :destroy

    validates :name, presence: true
    validates :name, length: { maximum: 30, minimum: 2 }
    validates :name, uniqueness: true

    private

    def log_before_destroy
        Rails.logger.info "##### Собираемся удалить пользователя #{@name} #####"
    end
    def log_after_destroy
        Rails.logger.info "##### Пользователь #{@name} удалён #####"
    end
end
