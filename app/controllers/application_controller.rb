class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in?

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!current_user
	end

	def require_user
		if !logged_in?
			flash[:danger] = "You must be logged in to perform that action"
			redirect_back(fallback_location: root_path)
		end
	end

	def require_same_user(user)
		if current_user != user
			flash[:danger] = "You can't do that"
			redirect_back(fallback_location: root_path)
		end
	end
end
