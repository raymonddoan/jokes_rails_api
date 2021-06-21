class UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    if @user.save
      # Generates an Auth token based on the user's id
      auth_token = Knock::AuthToken.new payload: {sub: @user.id}

      # returns the username and the JWT token that was just created to associate with the user
      render json: {username: @user.username, jwt: auth_token.token}, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # Signing in an old user into the API
  def sign_in
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      auth_token = Knock::AuthToken.new payload: {sub: @user.id}
      render json: {username: @user.username, jwt: auth_token.token}, status: 200      
    else
      render json: {error: "Incorrect username or password"}, status: 404
    end
  end
  
  

  private
  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
  
end
