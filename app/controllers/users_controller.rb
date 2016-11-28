class UsersController < ApplicationController

		# May try to make custom 404 page later
	# def index
	# 	not_found
	# end

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
		new_params = user_params.delete_if { |k, v| v.nil? || v.empty?}
		if @user.update(new_params)
			flash[:success] = "Profile Updated"
			redirect_to @user
		else
			flash[:notice] = "There was an error editing your profile. Please make sure all data is correct and try again."
			render 'edit'
		end
	end

	def destroy
	user = User.find(params[:id])
		session[:user_id] = nil
		user.destroy
		flash[:success] = "User record deleted"
		redirect_to root_path
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		def delete_blanks(hash)
			delete_if { |k, v| v.empty? || v.nil?}
		end

end