class SessionsController < ApplicationController 
	def destroy
		sign_out
   		redirect_to root_url

	end

	def create
	   user = User.find_by(userName: params[:session][:userName].downcase)
	  if user && user.authenticate(params[:session][:password])
	    sign_in user
      	redirect_to user
	  else
	    flash[:error] = 'Invalid email/password combination' # Not quite right!
	    render 'new'
	  end
	end

	def new

	end

end