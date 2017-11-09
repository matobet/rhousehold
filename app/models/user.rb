class User < ApplicationRecord

  scope :admins, -> { where(admin: true) }

  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 50 }

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /@/ },
    length: { maximum: 255 }

  validates :password,
    presence: true,
    confirmation: true,
    length: { minimum: 6 }

  has_secure_password

  before_save do
    email.downcase!
  end
end
