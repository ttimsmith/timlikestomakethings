class UsersController < ApplicationController

  def edit
    render layout: 'admin'
  end

  def index
    @members = User.members.order(:full_name).page(params[:page]).per_page(20)
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
      :name,
      :password,
      :slug,
      :stripe_token,
      :twitter_handle,
      :website
    )
  end
end
