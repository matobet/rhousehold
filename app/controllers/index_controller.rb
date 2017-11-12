class IndexController < ApplicationController
  def index
    if Setting.initialized
      redirect_to dashboard_url
    else
      render 'index'
    end
  end

  def init
    @admin = User.admins.new
    render 'init'
  end

  def do_init
    admin = User.admins.create(user_params)
    Setting.initialized = true

    redirect_to dashboard_url
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmtion)
  end
end
