class UsersController < ApplicationController

	def index
	  	if session[:user]
	  		@user = User.find(session[:user])
	  	end
	  	render "/index"
  	end

  	def show
  		if session[:user]
  			@user = User.find(session[:user])
  		end
  	end

  def edit
  	@user = User.find(session[:user]) if session[:user]
  end
	def create
		@user = User.new(user_params)
		if @user.save
			session[:user] = @user.id
			flash[:notice] = "Tu usuario se ha creado."
			redirect_to "/"
		else
			render "new"
		end
	end
  def connect
  	if env["omniauth.auth"]
  		user = User.where(provider_uid: env["omniauth.auth"]["info"]["uid"]).first
  		if !user
	  		user = User.new
	  		user.name = env["omniauth.auth"]["extra"]["raw_info"]["name"]
	  		user.email = env["omniauth.auth"]["extra"]["raw_info"]["email"]
	  		user.image = env["omniauth.auth"]["info"]["image"]
	  		user.gender = env["omniauth.auth"]["extra"]["raw_info"]["gender"]
	  		user.verified = env["omniauth.auth"]["extra"]["raw_info"]["verified"]
	  		user.provider_uid = env["omniauth.auth"]["info"]["uid"]
	  		if user.save
	  			session[:user] = user.id
	  			# UserMailer.email_verification(user.name, user.mail).deliver_now
	  			redirect_to "/"
	  		else
	  			flash[:notice] = "Los datos no se pudieron guardar."
	  			redirect_to "/"
	  		end
	  	else
	  		session[:user] = user.id
	  		redirect_to "/"
	  	end
  	elsif params[:error]
  		render plain: "#{params[:error]} #{params[:error_reason]}", content_type: "application/plain"
  	else	
  		render plain: "No se peudo conectar con #{params[:provider]}", content_type: "application/plain"
  	end
  end

  def destroy
  	session[:user] = nil
  	redirect_to "/"
  end

	  private
	  def user_params
	  	params.require(:user).permit(:name, :email, :password)
	  end
end
