class Account::BlogsController < ApplicationController
  def index
    @blogs = current_user.blogs
  end
end
