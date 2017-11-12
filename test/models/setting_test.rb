require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  test 'Read of unset seting returns nil' do
    assert_nil Setting.foo_bar
  end

  test 'Read set setting should return set value' do
    Setting.foo = 42
    assert_equal 42, Setting.foo

    Setting.bar = "foo"
    assert_equal "foo", Setting.bar

    Setting.baz = false
    assert_equal false, Setting.baz
  end

  test 'Should support komplex keys' do
    Setting.options = { foo: 42, bar: [1, '2'] }
    assert_equal({ foo: 42, bar: [1, '2'] }, Setting.options)
  end

  test 'Writing persists json representation' do
    Setting.foo = true
    setting = Setting.find_by(key: 'foo')
    assert_not_nil setting
    assert_equal 'true', setting.value
  end
end
