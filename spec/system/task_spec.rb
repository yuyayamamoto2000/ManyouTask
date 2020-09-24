require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do#describeには、「何の仕様についてなのか」
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do #contextには「状況・状態を分類」したテスト内容
      it '作成したタスクが表示される' do#itには「期待する動作」を記載します。
        visit new_task_path
        _task = Task.new
        fill_in 'task[title]', with: 'タスク名'
        fill_in 'task[content]',with: 'タスク詳細'
        click_on 'commit'
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

    context 'タスクが作成日時の降順に並んでる場合' do
      before do
        FactoryBot.create(:first_task)
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task)
      end
      it '新しいタスクが一番上に表示される' do
        #タスク一覧ページに遷移
        visit tasks_path
        task_list = all('td.task_row')
        expect(task_list[0]).to have_content 'name3'
      end
    end
    context 'タスクに終了期限が設けられてる場合' do
      before do
        FactoryBot.create(:first_task)
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task)
      end
      it '期限が迫っているタスクが一番上に表示される' do
        visit tasks_path
        click_on '終了期限でソートする'
        task_limit = all('td.task_limit_row')
        expect(task_limit[0]).to have_content '2020-09-30 12:00:00'
      end
    end
  end
  describe '詳細表示機能' do#describeには、「何の仕様についてなのか」
    context '任意のタスク詳細画面に遷移した場合' do#contextには「状況・状態を分類」したテスト内容
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'task5', content:'content5-show', time_limit: '2020-09-20 12:00:00' )
        visit task_path(task.id)
        expect(page).to have_content 'show'
      end
    end
  end
end
