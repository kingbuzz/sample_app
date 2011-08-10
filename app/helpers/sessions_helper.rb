module SessionsHelper

  def sign_in(user)    
    session[:remember_token] = [user.id, user.salt]
	#use this instead of reset_session, if you want to use cookies
    #cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user
  end
  
  def current_user  
    @current_user ||= user_from_remember_token
  end
  
  def current_user=(user)  
    @current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
	reset_session
	#use this instead of reset_session, if you want to use cookies
    #cookies.delete(:remember_token)
    self.current_user = nil
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
	  session[:remember_token] || [nil, nil]
	  #use this instead of reset_session, if you want to use cookies
      #cookies.signed[:remember_token] || [nil, nil]
    end
end