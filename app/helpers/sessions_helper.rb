module SessionsHelper
  def current_user
   @current_user ||= User.find_by(id: session[:user_id]) #@current_userが真の場合はそのままにし、偽の場合は右辺の値User.find_by(id: session[:user_id])を代入すると言う意味。
  end

  def logged_in?#ユーザーがログインしていればtrue、その他ならfalseを返すメソッドを定義
    current_user.present?
  end
  
  def login_checker
    if logged_in?
      flash[:notice] = 'ログイン中です'
      redirect_to tasks_path
    end
  end
end
