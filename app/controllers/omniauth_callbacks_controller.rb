class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    #render json: request.env['omniauth.auth']
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user,event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    end
  end

  def twitter
    # render json: request.env['omniauth.auth']
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      session["devise.omniauth"] = request.env['omniauth.auth'].except('extra')
      redirect_to new_omniauth_registration_path
    end
  end

end