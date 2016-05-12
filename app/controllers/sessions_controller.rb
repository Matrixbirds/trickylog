class SessionsController < ApplicationController

  layout 'login', only: %i[signin create]

  def signin
    @session = Session.new
    render 'new'
  end

  def create
    @session = Session.new(session_params)
    if self.current_user = @session.create
      redirect_to admin_root_path
    else
      flash[:failure] = " 登录失败 #{@session.errors}"
      render 'new'
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_path
  end

  private
    def session_params
      params.require(:session).permit(:username, :password)
    end
end
