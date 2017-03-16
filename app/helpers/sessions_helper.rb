module SessionsHelper
	
	def log_in(user)
	  session[:user_id] = user.id
	end

	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end
	def current_user?(user)
		user == current_user
	end

	#return the current user logged in
	def current_user
		if session[:user_id]
		  @current_user ||= User.find_by(id: session[:user_id])
		elsif cookies.signed[:user_id]
		  user = User.find_by(id: cookies.signed[:user_id])
		  if user && user.authenticated?(:remember, cookies[:remember_token])
		    log_in user
		    @current_user = user
		end
	end
	  #flash.now[:danger] = "#{session[:user_id]}"
	end

	#Check logged status
	def logged_in?
	  !current_user.nil?
	end

	#Logs out the current user
	def log_out
	  forget(current_user)
	  session.delete(:user_id)
	  @current_user = nil
	end

	#Redirects to stored location (or to the default).
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end
end
