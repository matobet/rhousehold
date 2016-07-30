class User < ApplicationRecord

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
    length: { minimum: 6 }

  before_save do
    email.downcase!
  end

  has_secure_password

  def self.new_admin **opts
    new **opts, admin: true
  end
end
