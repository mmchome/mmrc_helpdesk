module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
	def avatar_for(user)
	    #gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	    #size = options[:size]
	    #gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
	    #image_tag(gravatar_url, alt: "MMRC", class: "gravatar")
	    image_tag user.avatar_url(:thumb).to_s

	end

end
