class CommentsController < ApplicationController
  before_filter :find_post
  # before_filter :find_comment, only: [:destroy, :edit, :update]

  def create
    @comment = @post.comments.new comment_params
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), flash: { success: 'Comment created!' }
    else
      flash[:error] = @comment.errors.full_messages.join(', ')
      # render :new
    end
  end

  def destroy
    @post.comments.find(@comment).destroy
    redirect_to manage_post_comments_path(@post)
  end

  def edit
  end

  def update
    if @comment.update_attributes comment_params
      redirect_to post_comments_path(@post), flash: { success: 'Comment was successfully updated' }
    else
      flash[:error] = @comment.errors.full_messages.join(', ')
      render :edit
    end
  end

  private


  def find_post
    @post = if params[:comment].present? && params[:comment][:post_id].present?
      Post.find(params[:comment][:post_id])
    end

    @post ||= Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(
      :body,
      :user_id,
      :post_id
    )
  end
end
