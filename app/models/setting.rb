class Setting < ApplicationRecord
  def self.method_missing(method, *args)
    method = method.to_s

    if method[-1, 1] == '='
      set_setting(method.chop, args[0])
    else
      get_setting(method)
    end
  end

  def self.respond_to_missing?(*args)
    true
  end

  private_class_method def self.set_setting(key, value)
    setting = find_or_create_by(key: key)
    setting.value = ::Oj.dump(value)
    setting.save
  end

  private_class_method def self.get_setting(key)
    setting = find_by(key: key)

    ::Oj.load(setting.value) unless setting.nil?
  end
end
