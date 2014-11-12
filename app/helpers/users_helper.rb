module UsersHelper
	def avatar_for(user)
	    image_tag user.avatar_url(:thumb).to_s
	end

end
