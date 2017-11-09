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
    confirmation: true,
    length: { minimum: 6 }

  before_save do
    email.downcase!
  end

  has_secure_password

  def self.new_admin(opts = {})
    opts[:admin] = true
    new(opts)
  end

  def self.create_admin(opts = {})
    opts[:admin] = true
    create(opts)
  end
end
