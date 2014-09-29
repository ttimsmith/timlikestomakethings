class PostsController < ApplicationController
  before_filter :require_member_user

  def index
    @posts = Post.published.to_a
  end

  def show
    @post = Post.published.find(params[:id])
  end
end
