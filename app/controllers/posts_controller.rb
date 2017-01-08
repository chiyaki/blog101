class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_post_and_check_permission, only: [:edit, :update, :destroy]

    def index
      @blog = Blog.find(params[:blog_id])
      @posts = @blog.posts.all.recent
    end

    def new
      @blog = Blog.find(params[:blog_id])
      if current_user != @blog.user
        redirect_to root_path, alert: "You have no permission."
      else
        @post = Post.new
      end
    end

    def create
      @blog = Blog.find(params[:blog_id])
      @post = Post.new(post_params)
      @post.blog = @blog
      @post.user = current_user

      if @post.save
        redirect_to blog_posts_path(@blog)
      else
        render :new
      end
    end

    def show
      @blog = Blog.find(params[:blog_id])
      @post = Post.find(params[:id])
    end

    def edit
    end

    def update
      if @post.update(post_params)
        redirect_to blog_posts_path(@blog), notice: "Update Success"
      else
        render :edit
      end
    end

    def destroy
      @post.destroy
      flash[:alert] = "Post deleted"
      redirect_to blog_posts_path(@blog)
    end

    private

    def find_post_and_check_permission
      @blog = Blog.find(params[:blog_id])
      @post = Post.find(params[:id])
      if current_user != @post.user
        redirect_to root_path, alert: "You have no permission."
      end
    end


    def post_params
      params.require(:post).permit(:title, :article)
    end
end
