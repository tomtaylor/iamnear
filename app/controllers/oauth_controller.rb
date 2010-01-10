class OauthController < ApplicationController

  def auth
    if session[:request_token] && session[:request_token_secret]
    
      fe = FireEagle::Client.new(:consumer_key => CONSUMER_KEY, :consumer_secret => CONSUMER_SECRET, :request_token => session[:request_token], :request_token_secret => session[:request_token_secret])
    
      access_token = fe.convert_to_access_token(params[:oauth_verifier])

      session[:request_token] = nil
      session[:request_token_secret] = nil
      session[:access_token] = access_token.token
      session[:access_token_secret] = access_token.secret
    
      redirect_to :controller => 'home', :subdomain => session[:subdomain], :fireeagle => true
    else
      flash[:warning] = "You probably don't want to be here without having tried to authorize first."
      redirect_to '/'
    end
  end
  
  def logout
    reset_session
    flash[:notice] = "You've been logged out of Fire Eagle."
    redirect_to '/'
  end

end
