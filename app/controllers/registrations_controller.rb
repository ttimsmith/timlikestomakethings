class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @user = User.create(user_params)

    if @user.errors.none?
      redirect_to root_path, flash: 'foo'
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    super
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :name,
      :password_confirmation,
      :stripe_token
    )
  end
end
