class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource
    if resource.valid_with_captcha?
      super
    else
      clean_up_passwords(resource)
      render 'devise/registrations/new'
    end
  end
end