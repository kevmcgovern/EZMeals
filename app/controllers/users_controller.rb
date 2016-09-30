class UsersController < ApplicationController
	
	def new
	end

	def show
		@user = User.find(params[:id])
		if @user
			link_to user_path(@user)
		else
			redirect_to '/'
		end
	end

	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			link_to user_path(user)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end