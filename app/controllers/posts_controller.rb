class PostsController < ApplicationController
  before_filter :require_member_user
  layout 'admin'

  def index
    @posts = Post.published.order('created_at DESC').with_comment_count.to_a
  end

  def show
    @post = Post.published.find(params[:id])
    @comment = Comment.new

    @comments = @post.comments.to_a
  end
end
