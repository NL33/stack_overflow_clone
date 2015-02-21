class User < ActiveRecord::Base

  has_secure_password

  validates_uniqueness_of :name
  validates_uniqueness_of :email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true,
            case_sensitive: false
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_digest, presence: true, uniqueness: true

  has_many :questions

  has_many :answers
  has_many :upvotes

end