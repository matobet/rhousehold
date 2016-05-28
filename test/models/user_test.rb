require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = User.new(name: 'john', email: 'john@example.com')
  end

  test 'basic valid user' do
    assert @user.valid?
  end

  test 'should create admin user' do
    user = User.new_admin
    assert user.admin?
  end

  test 'should create non-admin user by default' do
    assert_not @user.admin?
  end

  test 'should validate blank username' do
    @user.name =  '      '
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
    duplicate = @user.dup
    assert_not duplicate.valid?
  end

  test 'should validate uniqueness of email' do
    @user.save
    duplicate = User.new(name: 'fred', email: @user.email)
    assert_not duplicate.valid?

    duplicate.email.upcase!
    assert_not duplicate.valid?
  end

  test 'email is downcased before save' do
    @user.email.upcase!
    @user.save
    assert_equal 'john@example.com', @user.email
  end
end
