class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    return unless authorized
    @post = Post.new
    @username = @current_user.username
  end

  def create
    return unless authorized
    @post = Post.create!(post_params)
    @username = @current_user.username
    redirect_to post_url(@post)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)

    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :author, :content)
  end
end
