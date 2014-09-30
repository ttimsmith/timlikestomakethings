class UsersController < ApplicationController

  def edit
  end

  def index
    # users = User.order(:full_name)
    @members = User.order(:full_name)
    # @members = users.members.page(params[:page]).per_page(20).to_a
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    if current_user.update_attributes user_params
      redirect_to root_path, flash: { success: 'You have successfully updated your profile' }
    else
      flash[:error] = current_user.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :bio,
      :email,
      :full_name,
      :password,
      :slug,
      :twitter_handle,
      :website
    )
  end
end
