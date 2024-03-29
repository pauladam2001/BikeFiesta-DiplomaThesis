# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    require 'open-uri'

    begin
      link = 'http://localhost:8000/api/extract?token=24apa2001'
      bodyCall = { "file": params[:user][:avatar] }
      h = HTTParty.post(link, body: bodyCall, timeout: 30)
    rescue Exception => e
      puts e
      redirect_to new_user_session_path, alert: "Error - Couldn't communicate with the API. Try again later."
      return
    end

    if h.include?("cloudinary.com")
      file = URI.open(h)

      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?

      resource.avatar.attach(io: file, filename: 'image' + Random.rand(999999999).to_s + '.jpg')

      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          # sign_up(resource_name, resource)
          # respond_with resource, location: after_sign_up_path_for(resource)
          Notification.create(notification_type: "paypal_edit", notified_id: resource.id, message: "Please introduce your PayPal email")
          redirect_to new_user_session_path, alert: "Account created successfully."
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        # clean_up_passwords resource
        # set_minimum_password_slength
        # respond_with resource
        if resource.errors.full_messages.first == "Password is invalid"
          error_message = "The password should have more than 6 characters including 1 uppercase letter, 1 number and 1 special character"
        else
          error_message = resource.errors.full_messages.first
        end
        redirect_to new_user_session_path, alert: "Error - #{error_message}."
      end
    else
      error_message = h
      redirect_to new_user_session_path, alert: "Error - #{error_message}."
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    user = User.where(email: params[:user][:email]).first
    if user.provider == "google_oauth2"
      user.paypal_email = params[:user][:paypal_email]
      user.phone = params[:user][:phone]
      user.save(validate: false)

      redirect_to posts_path, alert: "Account updated successfully."
    else
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      if resource_updated
        set_flash_message_for_update(resource, prev_unconfirmed_email)
        bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

        respond_with resource, location: after_update_path_for(resource)
      else
        # clean_up_passwords resource
        # set_minimum_password_length
        # respond_with resource
        if resource.errors.full_messages.first == "Password is invalid"
          error_message = "The password should have more than 6 characters including 1 uppercase letter, 1 number and 1 special character"
        else
          error_message = resource.errors.full_messages.first
        end
        redirect_to edit_user_registration_path, alert: "Error - #{error_message}."
      end
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar, :phone, :sms_opt_in])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :paypal_email])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
