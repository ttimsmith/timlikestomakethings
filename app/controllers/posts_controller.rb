class PostsController < ApplicationController
  before_filter :require_member_user
  before_filter :find_post, only: :show

  def index
    @posts = Post.published.to_a
  end

  def show
    @comments = @post.comments.includes(:user).order('created_at DESC').to_a
  end

  def find_post
    @post = Post.published.find(params[:id])
  end

end
