module ApplicationHelper

	def login_helper
		if current_user
			(link_to "Sign out", destroy_user_session_path, method: :delete)
		else
			(link_to "Sign up", new_user_registration_path) + " | " +
				(link_to "Sign in", new_user_session_path)
		end
	end

end
