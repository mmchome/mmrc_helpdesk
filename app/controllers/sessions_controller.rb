class SessionsController < ApplicationController 
	def destroy
		sign_out
   		redirect_to root_url

	end

	def create
	   user = User.find_by(username: params[:session][:username].downcase)
	  if user && user.authenticate(params[:session][:password])
	    sign_in user
      	redirect_to user
	  else
	    flash[:error] = 'Invalid username/password combination' #
	    render 'new'
	  end
	end

	def new

	end

end