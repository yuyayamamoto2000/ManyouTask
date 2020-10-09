class SessionsController < ApplicationController
  def new
    login_checker
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase) #ここで送信されたメールアドレスをfind_byメソッドでユーザーから呼び出している
    if user && user.authenticate(params[:session][:password])
      # ログイン成功した場合
      session[:user_id] = user.id #メールアドレスとパスワードが有効だった場合は、sessionメソッドを使用してログインを行う
      redirect_to user_path(user.id) #ユーザー詳細ページにリダイレクトする。
    else
      # ログイン失敗した場合
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました。'
    redirect_to new_session_path
  end
end
