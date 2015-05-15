class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  around_action :sign_in_all

  def facebook
  end

  def twitter
  end

  private

  def sign_in_all
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    auth = request.env['omniauth.auth']
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: auth.provider.capitalize) if is_navigational_format?
    else
      session["devise.omniauth"] = request.env['omniauth.auth'].except('extra')
      redirect_to new_omniauth_registration_path
    end
  end
  
end
