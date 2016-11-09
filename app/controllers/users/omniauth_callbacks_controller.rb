class Users::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  def omniauth_success
    get_resource_from_auth_hash
    create_token_info
    set_token_on_resource
    create_auth_params

    if resource_class.devise_modules.include?(:confirmable)
      # don't send confirmation email!!!
      @resource.skip_confirmation!
    end

    sign_in(:user, @resource, store: false, bypass: false)
    @resource.save!
    yield @resource if block_given?

    render_data_or_redirect('deliverCredentials', @auth_params.as_json, @resource.as_json)
  end

  private

  def set_token_on_resource
    @resource.tokens[@client_id] = {
      token: BCrypt::Password.create(@token),
      expiry: @expiry
    }
  end

  def get_resource_from_auth_hash
    provider = AuthenticationProvider.where(name: auth_hash.provider).first
    authentication = provider.user_authentications.where(uid: auth_hash.uid).first if provider
    existing_user = current_user || User.where('email = ?', auth_hash['info']['email']).first

    if authentication
      set_user_from_existing_authentication(authentication)
    elsif existing_user
      set_user_and_create_authentication(auth_hash, existing_user, provider)
    else
      create_and_set_user_and_authentication(auth_hash, provider)
    end

    if @resource.new_record?
      @oauth_registration = true
      set_random_password
    end

    # sync user info with provider, update/generate auth token
    assign_provider_attrs(@resource, auth_hash)

    # assign any additional (whitelisted) attributes
    extra_params = whitelisted_params
    @resource.assign_attributes(extra_params) if extra_params

    @resource
  end

  def set_user_from_existing_authentication(authentication)
    @resource = authentication.user
  end

  def set_user_and_create_authentication(auth_params, user, provider)
    UserAuthentication.create_from_omniauth(auth_params, user, provider)
    @resource = user
  end

  def create_and_set_user_and_authentication(auth_params, provider)
    user = User.create_from_omniauth(auth_params)

    if user.valid?
      set_user_and_create_authentication(auth_params, user, provider)
    else
      render_data_or_redirect('authFailure', { error: user.errors })
    end
  end
end
