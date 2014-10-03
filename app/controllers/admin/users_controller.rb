class Admin::UsersController < Admin::BaseController
  before_filter :find_user, only: [:edit, :update]

  def create
    @user = User.create(user_params)

    if @user.errors.none?
      redirect_to admin_users_path, flash: { success: 'User Created!' }
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @roles = Role.all
  end

  def index
    @users = User.all.to_a
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def update
    if @user.update_attributes user_params
      redirect_to admin_users_path, flash: { success: "#{@user.full_name} was successfully updated." }
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :bio,
      :email,
      :full_name,
      :password,
      :role_id,
      :slug,
      :twitter_handle,
      :website
    )
  end
end
