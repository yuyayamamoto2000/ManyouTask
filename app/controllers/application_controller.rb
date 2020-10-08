class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def authenticate_user
    # 現在ログイン中のユーザが存在しない場合、ログインページにリダイレクトさせる。
    if @current_user == nil
      flash[:notice] = t('notice.login_needed')
      redirect_to new_session_path
    end
  end
  def admin_user?
   if current_user.admin != true
     if current_user.id != params[:id].to_i
       flash[:notice] = "権限がありません。"
       redirect_to tasks_path
     end
   end
 end
 def me?
   @user = User.find(params[:id])
   unless current_user == @user
     flash[:notice] = "アクセスできません。"
     redirect_to new_session_path
   end
 end
end
