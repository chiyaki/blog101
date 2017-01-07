class PostsController < ApplicationController
  def index
    @posts = Post.all.recent.paginate(:page => params[:page], :per_page => 5)
  end
end
