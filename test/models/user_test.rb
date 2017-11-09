require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(
      name: 'john',
      email: 'john@example.com',
      password: 'secure',
      password_confirmation: 'secure'
    )
    def @user.dup_with(fields)
      dup.tap { |user| user.update_attributes(fields) }
    end
  end

  test 'basic valid user' do
    assert @user.valid?
  end

  test 'should create admin user' do
    user = User.admins.new
    assert user.admin?
  end

  test 'should create admin user with name set' do
    user = User.admins.new name: 'root'
    assert_equal 'root', user.name
  end

  test 'should create non-admin user by default' do
    assert_not @user.admin?
  end

  test 'should validate blank username' do
    @user.name = ' ' * 6
    assert_not @user.valid?

    @user.name = nil
    assert_not @user.valid?
  end

  test 'should validate email for presence of "@"' do
    @user.email = 'xyz.com'
    assert_not @user.valid?
  end

  test 'should validate max username length' do
    @user.name = 'j' * 51
    assert_not @user.valid?
  end

  test 'should validate max email length' do
    @user.email = 's' * 250 + '@example.com'
    assert_not @user.valid?
  end

  test 'should validate uniqueness of username' do
    @user.save
    duplicate = @user.dup_with email: 'johnny2@example.com'
    assert_not duplicate.valid?
  end

  test 'should validate uniqueness of email' do
    @user.save
    duplicate = @user.dup_with name: 'fred'
    assert_not duplicate.valid?

    duplicate.email.upcase!
    assert_not duplicate.valid?
  end

  test 'email is downcased before save' do
    @user.email.upcase!
    @user.save
    assert_equal 'john@example.com', @user.email
  end

  test 'password should be present' do
    @user.password = @user.password_confirmation = ' ' * 5
    assert_not @user.valid?
  end

  test 'password should have min length' do
    @user.password = @user.password_confirmation = 'a'
    assert_not @user.valid?
  end
end
