class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @users = User.all
  end

  # def verify_unapproved
  #   redirect_to dashboard_path unless current_user.admin
  # end

  # def verify_approved
  #   redirect_to dashboard_path unless current_user.try(:organization).try(:approved?)
  # end

  # def verify_user
  #   redirect_to dashboard_path unless current_user.try(:organization).try(:approved?) || current_user.admin?
  # end
end
