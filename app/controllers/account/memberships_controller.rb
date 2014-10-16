class Account::MembershipsController < ApplicationController
  layout 'admin'

  def show
    @user = current_user
    @plan = @user.plan
  end

end
