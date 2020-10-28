class SessionsController < ApplicationController

  def reset
    reset_session
    flash[:notice] = "Good Bye"
    redirect_to root_path
  end
end
