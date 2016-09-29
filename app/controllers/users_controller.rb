class UsersController < ApplicationController
	
	def new
	end

	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			link_to user_path(user)
		else
			redirect_to '/users/new'
		end
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end