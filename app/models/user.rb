class User < ApplicationRecord
  TEMP_EMAIL_REGEX = /\Atest@mmail.com/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable
    before_destroy :log_before_destroy
    after_destroy :log_after_destroy

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :commented_posts, through: :comments, source: :commentable, source_type: :Post
    has_many :commented_users, through: :comments, source: :commentable, source_type: :User
    has_many :marks, dependent: :destroy
    has_one :seo, as: :seoable, dependent: :destroy
    has_many :identities, dependent: :destroy

    validates :name, presence: true
    validates :name, length: { maximum: 30, minimum: 2 }
    validates :name, uniqueness: true

    def email_verified?
      self.email && self.email !~ TEMP_EMAIL_REGEX
    end

    private

    def log_before_destroy
        Rails.logger.info "##### Собираемся удалить пользователя #{@name} #####"
    end
    def log_after_destroy
        Rails.logger.info "##### Пользователь #{@name} удалён #####"
    end

    def self.find_for_oauth(auth, signed_in_resource = nil)

      # Получить identity пользователя, если он уже существует
      identity = Identity.find_for_oauth(auth)
  
      # Если signed_in_resource предоставлен оно всегда переписывает существующего пользователя
      # что бы identity не была закрыта случайно созданным аккаунтом.
      # Заметьте, что это может оставить зомби-аккаунты (без прикрепленной identity)
      # которые позже могут быть удалены
      user = signed_in_resource ? signed_in_resource : identity.user
  
      # Создать пользователя, если нужно
      if user.nil?
  
        # Получить email пользователя, если его предоставляет провайдер
        # Если email не был предоставлен мы даем пользователю временный и просим
        # пользователя установить и подтвердить новый в следующим шаге через UsersController.finish_signup
        email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
        email = auth.info.email if email_is_verified
        user = User.where(:email => email).first if email
  
        # Создать пользователя, если это новая запись
        # Здесь нужны обработчики для каждого провайдера, т.к. хэш
        # с данными возвращается с разной структурой
        if user.nil?
          user = User.new(
            name: auth.extra.raw_info.name? ? auth.extra.raw_info.name : FFaker::Internet.user_name[0..16],
            #username: auth.info.nickname || auth.uid,
            email: auth.extra.raw_info.email? ? auth.extra.raw_info.email : FFaker::Internet.safe_email,
            password: Devise.friendly_token[0,20]
          )
          # user.skip_confirmation!
          # byebug
          user.save!
        end
      end
  
      # Связать identity с пользователем, если необходимо
      if identity.user != user
        identity.user = user
        identity.save!
      end
      user
    end
    
end
