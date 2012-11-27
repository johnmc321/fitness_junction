module SessionsHelper
	def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  # check to see if current_user is not nil
  def signed_in?
    !current_user.nil?
  end

  # defines the current_user= method so that it can be called on self (@current_user sets an instance variable)
  def current_user=(user)
    @current_user = user
  end

  # if the current_user instance variable is undefined, it is set to the user corresponding to the remember token, otherwise it returns @current_user
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
