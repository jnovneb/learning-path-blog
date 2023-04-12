class BlogPostsController < ApplicationController

  before_action :set_blog_post, only: [:show, :edit, :update, :delete]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @blog_posts = user_signed_in? ? BlogPost.sorted : BlogPost.published.sorted
    @pagy, @blog_posts = pagy(@blog_posts)
  end

  def show
    @blog_post = BlogPost.published.find(params[:id])
  end
  def new
    @blog_post = BlogPost.new
  end
  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :published_at)
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
    @blog_post.destroy
    redirect_to root_path
  end

  def set_blog_post
    if user_signed_in?
      @blog_post = BlogPost.find(params[:id])
    else
      @blog_post = BlogPost.published.find(params[:id])
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end