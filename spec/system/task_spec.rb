require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do#describeには、「何の仕様についてなのか」

  let!(:first_task){ FactoryBot.create(:first_task, user: user) }
  let!(:second_task){ FactoryBot.create(:second_task, user: user) }
  let!(:third_task){ FactoryBot.create(:third_task, user: user) }
  let!(:user){ FactoryBot.create(:user) }
  # let(:label_list){ FactoryBot.create_list(:label, 10) }
  before do
    visit new_session_path
    fill_in 'session[email]', with: 'test@gmail.com'
    fill_in 'session[password]',with: 'password'
    click_on 'commit'
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do #contextには「状況・状態を分類」したテスト内容
      it '作成したタスクが表示される' do#itには「期待する動作」を記載します。
        visit new_task_path
        #_task = Task.new
        #binding.pry
        # select '2020', from: 'task[time_limit(1i)]'
        fill_in 'task[title]', with: 'タスク名'
        fill_in 'task[content]',with: 'タスク詳細'
        select 2018, from: 'task_time_limit_1i'
        select '未着手', from: 'task_priority'
        check "label_6"
        click_on 'commit'
        expect(page).to have_content 'タスク名'
        #expect(page).to have_content 'タスク詳細'
        # expect(page).to have_content  #'2020-09-21 12:00:00'
        # expect(page).to have_content 0
      end
    end
  end
  describe '一覧表示機能' do#describeには、「何の仕様についてなのか」
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        # _task = FactoryBot.create(:task, title: 'task')
        # タスク一覧ページに遷移
        visit new_task_path
        _task = Task.new
        #binding.pry
        select '2020', from: 'task[time_limit(1i)]'
        fill_in 'task[title]', with: 'task'
        fill_in 'task[content]',with: 'task'
        select 2018, from: 'task_time_limit_1i'
        select '未着手', from: 'task_priority'
        click_on 'commit'
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end

      context 'タスクが作成日時の降順に並んでる場合' do
        # before do
        #   FactoryBot.create(:first_task)
        #   FactoryBot.create(:second_task)
        #   FactoryBot.create(:third_task)

        # end
        it '新しいタスクが一番上に表示される' do
          #タスク一覧ページに遷移
          visit tasks_path
          # binding.pry
          task_list = all('td.task_row')

          expect(task_list[0]).to have_content 'name1'
        end
      end
      context 'タスクに終了期限が設けられてる場合' do
        it '期限が迫っているタスクが一番上に表示される' do
          visit tasks_path
          click_on '終了期限でソートする'
          sleep(0.8)
          task_limit = all('td.task_limit_row')
          expect(task_limit[0]).to have_content '2020-09-30 12:00:00'
        end
      end
      context 'タスクに優先順位が設けられてる場合' do
        it '優先順位が高い順に並び替える' do
          visit tasks_path
          click_on '優先順位でソートする'
          sleep(0.8)
          task_to_do = all('td.task_to_do')
          expect(task_to_do[0]).to have_content '高'
        end
      end

    end
    describe '詳細表示機能' do#describeには、「何の仕様についてなのか」
      context '任意のタスク詳細画面に遷移した場合' do#contextには「状況・状態を分類」したテスト内容
        it '該当タスクの内容が表示される' do
          # task = FactoryBot.create(:task, title: 'task5', content:'content5-show', time_limit: '2020-09-20 12:00:00' )
          # visit tasks_path
          visit tasks_path
          task_list = all(".task_list")
          first('.task_list').click_link '詳細を確認する'
          expect(page).to have_content 'name1'

        end
      end
    end

    describe '検索機能' do
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit tasks_path
          # タスクの検索欄に検索ワードを入力する (例: task)
          fill_in 'search[title]', with: '3'
          # 検索ボタンを押す
          click_on :commit
          expect(page).to have_content 'name3'
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          visit tasks_path
          select "未着手", from: 'search[priority]'
          expect(page).to have_content 'name3'
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit tasks_path
          fill_in 'search[title]', with: 'name3'
          select '未着手', from: 'search[priority]'
          expect(page).to have_content 'name3'
        end
      end
      context 'ラベル検索を実行した場合' do
        it "ラベル検索のみ" do
            visit tasks_path

            select 'label_2', from: 'search[label_id]'
            click_on :commit
            expect(page).to have_content 'name1'
        end
      end
  end
end
