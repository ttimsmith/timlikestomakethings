class Manage::PostsController < Manage::BaseController
  before_filter :find_post, only: [:edit, :destroy, :update]

  def create
    @post = current_user.posts.create post_params

    if @post.errors.none?
      redirect_to manage_posts_path, flash: { success: 'Post Created!' }
    else
      flash[:error] = @post.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
  end

  def destroy
    @post.find.destroy
    redirect_to manage_posts_path
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def update
    if @post.update_attributes post_params
      redirect_to manage_posts_path(@post), flash: { success: "#{@post.title} was successfully updated."}
    else
      flash[:error] = @post.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :post_content,
      :title,
      :state
    )
  end

  def find_post
    @post = current_user.posts.find(params[:id])
  end

end
