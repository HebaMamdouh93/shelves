module Api::V1::User
  class Api::V1::User::AuthenticationController < ApiController
      skip_before_action :authenticate_request, only: :authenticate

      def authenticate
        command = AuthenticateUser.call(params[:email], params[:password])
    
        if command.success?
          @user= User.find_by_email(params[:email])
          if  @user.email_confirmed
            
            render json: {status: 'SUCCESS',user: @user, auth_token: command.result }, :except => [:password_digest], status: :created
          else 
            render json: {status: 'FAIL', message: "inactive!"}, status: :ok
           
          end
        else
          render json: {status: 'FAIL', message: "invalid username or password" }, status: :ok
        end
      end



    
  end
end
