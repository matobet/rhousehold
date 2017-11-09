class IndexController < ApplicationController
  def index
    render 'index'
  end

  def init
    @admin = User.new_admin
    render 'init'
  end

  def do_init
    admin = User.create_admin(user_params)
    
  end

  def user_params
    params
        .require(:name)
        .require(:email)
        .require(:password)
        .require(:password_confirmation)
  end
end
