class RegistrationsController < Devise::RegistrationsController
  before_filter :plans

  def new
    super
  end

  def create
    @user = User.create(user_params)

    if @user.errors.none?
      redirect_to posts_path, flash: { success: 'Welcome to the membership!' }
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    super
  end

  private

  def plans
    @plans = Plan.all
  end

  def user_params
    params.require(:user).permit(
      :bio,
      :email,
      :password,
      :name,
      :password_confirmation,
      :plan_id,
      :stripe_token,
      :twitter_handle
    )
  end
end
