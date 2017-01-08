class BlogsController < ApplicationController
  before_action :authenticate_user! , except: [:show]
  before_action :find_blog_and_check_permission, only: [:edit, :update, :destroy]

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user
    if @blog.save
      redirect_to account_blogs_path
    else
      render :new
    end
  end

  def show
    @blog = Blog.find(params[:id])
    @posts = @blog.posts.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to account_blogs_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    flash[:alert] = "Group deleted"
    redirect_to account_blogs_path
  end

  private

  def find_blog_and_check_permission
    @blog = Blog.find(params[:id])
    if current_user != @blog.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def blog_params
    params.require(:blog).permit(:title, :description)
  end

end
