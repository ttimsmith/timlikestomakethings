class PostsController < ApplicationController
  before_filter :require_member_user
  before_filter :find_post, only: :show
  layout 'admin'

  def index
    @posts = Post.published.order('created_at DESC').with_comment_count.to_a
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order('created_at ASC').to_a
  end

  def find_post
    @post = Post.published.find(params[:id])
  end

end
