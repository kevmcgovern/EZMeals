class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:success] = 'Successfully logged in'
			redirect_to user
		else
			flash[:notice] = 'Unsuccessful log in attempt. Please check your credentials and try again.'
			redirect_to '/login'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to '/login'
	end

end