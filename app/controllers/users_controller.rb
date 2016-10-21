class UsersController < ApplicationController

	def new
	end

	def show
		@user = User.find(params[:id])
		if @user
			render 'show'
		else
			redirect_to '/'
		end
	end

	def create
		user = User.new(user_params)
		p user
		user.save
		if user.save
			session[:user_id] = user.id
			redirect_to user
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile Updated"
			redirect_to @user
		else
			flash[:failure] = "Something went wrong"
			redirect_to @user
		end
	end

	def destroy
		user = User.find(params[:id])
		flash[:notice] = "Are you sure you want to delete your account?"
		user.destroy
		flash[:success] = "User record deleted"
		redirect_to root_path
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end