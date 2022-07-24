class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_one_attached :avatar
  before_commit :add_default_avatar, on: %i[create update]

  # shorthand for getter & setter
  attr_accessor :login
  validate :validate_username

  # # getter
  # def login
  #   @login || username || email
  # end

  # # setter
  # def login=(str)
  #  @login = str
  # end

  # extends Devise to query via warden
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize_to_limit: [50, 50]).processed
    else
      '/default_profile.png'
    end 
  end

  private
  
  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_profile.png'
          )
        ), 
        filename: 'default_profile.png',
        content_type: 'image/png'
      )
    end
  end
end
