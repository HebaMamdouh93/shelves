module Api::V1::User
  class Api::V1::User::AuthenticationController < ApiController
      skip_before_action :authenticate_request, only: :authenticate

      def authenticate
        command = AuthenticateUser.call(params[:email], params[:password])
    
        if command.success?
          @user= User.find_by_email(params[:email])
          if  @user.email_confirmed
            if params[:remember_me]
              
            else
              
            end
            render json: {user: @user, auth_token: command.result }, :except => [:password_digest], status: :created
          else 
            render json: :inactive
          end
        else
          render json: { error: command.errors }, status: :unauthorized
        end
      end



    
  end
end
