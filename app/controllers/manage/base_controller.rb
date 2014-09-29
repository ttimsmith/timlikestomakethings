class Manage::BaseController < ApplicationController
  before_filter :require_admin_user
end
