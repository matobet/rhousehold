class IndexController < ApplicationController
  def index
    render 'index'
  end

  def init
    @admin = User.admin.new
    render 'init'
  end

  def do_init
    admin = User.admins.create(user_params)

  end

  def user_params
    params
        .require(:name)
        .require(:email)
        .require(:password)
        .require(:password_confirmation)
  end
end
