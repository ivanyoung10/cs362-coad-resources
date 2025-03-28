# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController

  # https://github.com/heartcombo/devise/wiki/How-To:-Use-Recaptcha-with-Devise
  # prepend_before_action :check_captcha, only: [:create]

  def create
    super do |resource|
      resource.skip_confirmation!
      resource.save
    end
  end

  private

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      resource.validate
      set_minimum_password_length
      respond_with_navigational(resource) { render :new }
    end
  end

end
