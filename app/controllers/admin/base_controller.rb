class Admin::BaseController < ApplicationController
  before_filter :require_admin_user
  layout 'admin'
end
