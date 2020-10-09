require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do#describeには、「何の仕様についてなのか」

  let!(:user){ FactoryBot.create(:user) }
  let!(:admin_user){ FactoryBot.create(:admin_user) }

  describe 'ユーザー登録' do
    context 'ユーザーが新規作成した場合' do #contextには「状況・状態を分類」したテスト内容
      before do
        visit new_user_path
      end
      it '作成したユーザーが表示される' do#itには「期待する動作」を記載します。
        fill_in 'user[name]', with: 'user'
        fill_in 'user[email]',with: 'user@gmail.com'
        fill_in 'user[password]',with: 'user@gmail.com'
        fill_in 'user[password_confirmation]',with: 'user@gmail.com'
        click_on 'commit'
        expect(page).to have_content 'user'
      end
      it 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移する' do
        visit tasks_path
          expect(page).to have_content 'notice.login_needed'
      end
    end
  end
  describe 'セッション機能テスト' do
  context '一般ユーザー' do
    it "ログインができる事" do
      visit new_session_path
      fill_in 'session[email]',with: 'test@gmail.com'
      fill_in 'session[password]',with: 'password'
      sleep 0.5
      click_on 'commit'
      expect(page).to have_content 'タスク一覧'
    end
  end
    context 'ログインしている場合' do
      before do
        visit new_session_path
        fill_in 'session[email]',with: 'test@gmail.com'
        fill_in 'session[password]',with: 'password'
        sleep 0.5
        click_on 'commit'
      end
      it "詳細ページに移動" do
        click_on 'Profile'
        expect(page).to have_content 'test@gmail.com'
      end
      it '他人の詳細ページにとぶとタスク一覧画面に戻されること' do
        visit user_path(admin_user.id)
        expect(page).to have_content 'アクセスできません。'
      end
      it 'ログアウトができる' do
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました。'
      end
    end
  end
  describe '管理者のテスト' do
    before do
      visit new_session_path
      fill_in 'session[email]',with: 'admin@example.com'
      fill_in 'session[password]',with: 'password'
      sleep 0.5
      click_on 'commit'
    end
    context '管理者権限' do
      it "admin_userは管理者画面にアクセスできる事" do
        visit admin_users_path
        expect(page).to have_content 'ユーザーid'
      end
      it "userは管理画面にアクセスできない" do
        click_on 'Logout'
        visit new_session_path
        fill_in 'session[email]',with: 'test@gmail.com'
        fill_in 'session[password]',with: 'password'
        sleep 0.5
        click_on 'commit'
        visit admin_users_path
        expect(page).to have_content '管理者以外アクセスできません。'
      end
      it "admin_userはuserの新規登録ができる" do
        visit admin_users_path
        click_on '新しくユーザーを追加する'
        fill_in 'user[name]', with: 'apex'
        fill_in 'user[email]', with: 'apex@gmail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'commit'
        expect(page).to have_content 'apex'
      end
      it "admin_userはユーザーの詳細画面を閲覧できる。" do
        visit admin_users_path(user.id)
        user_list = all(".user_list")
        first('.user_list').click_link '詳細を確認する'
        expect(page).to have_content 'test'
      end
      it "admin_userは編集画面からuser情報を編集できる。" do
        visit edit_admin_user_path(user.id)
        fill_in 'user[name]', with: 'apex'
        fill_in 'user[email]', with: 'apex@gmail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'commit'
        expect(page).to have_content 'apex'
      end
      it "admin_userはuserを削除できる" do
        visit admin_users_path(user.id)
        user_list = all(".user_list")
        first('.user_list').click_link '詳細を確認する'
        expect(page).to have_content 'test'
        click_on 'userを削除する'
        expect(page).to have_content 'admin_user'
      end
    end
  end
end
