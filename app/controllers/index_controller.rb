class IndexController < ApplicationController
  def index
    render 'index'
  end

  def init
    @admin = User.new_admin
    render 'init'
  end

  def do_init

  end
end
