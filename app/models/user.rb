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

  before_save do
    email.downcase!
  end

  def self.new_admin
    user = new
    user.admin = true
    user
  end
end
