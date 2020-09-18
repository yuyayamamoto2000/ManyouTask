require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do#describeには、「何の仕様についてなのか」
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do #contextには「状況・状態を分類」したテスト内容
      it '作成したタスクが表示される' do#itには「期待する動作」を記載します。
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        visit new_task_path
        # 2. 新規登録内容を入力する
        _task = Task.new
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'task[title]', with: 'タスク名'
        # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'task[content]',with: 'タスク詳細'
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        click_on 'commit'
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）をexpect確認（期待）するコードを書く
        # binding.irb
        expect(page).to have_content 'タスク名'
        expect(page).to have_content 'タスク詳細'
      end
    end
  end
  describe '一覧表示機能' do#describeには、「何の仕様についてなのか」
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        _task = FactoryBot.create(:task, title: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end
  describe '詳細表示機能' do#describeには、「何の仕様についてなのか」
    context '任意のタスク詳細画面に遷移した場合' do#contextには「状況・状態を分類」したテスト内容
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'task5', content:'content5-show', time_limit: '2020-10-01 12:00:00', status: '未着手',priority: '中')
        visit task_path(task.id)
        expect(page).to have_content 'show'
      end
    end
  end
end
