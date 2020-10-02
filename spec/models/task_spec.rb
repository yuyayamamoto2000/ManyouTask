require 'rails_helper'
RSpec.describe Task, type: :model do
  describe 'タスクモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(title: '', content: '失敗テスト')
          expect(task).not_to be_valid
        end
      end
      context 'タスクの詳細が空の場合' do
        it 'バリデーションにひっかかる' do
          # ここに内容を記載する
          task = Task.new(title: '失敗テスト', content:'')
          expect(task).not_to be_valid
        end
      end
      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          # ここに内容を記載する
          _task = Task.new(title: '成功テスト', content: '成功テスト')
        end
      end
    end
  end
    describe '検索機能' do
      # 必要に応じて、テストデータの内容を変更して構わない
      task = FactoryBot.create(:first_task, title: 'name1')
      second_task = FactoryBot.create(:second_task, title: "name2")
      context 'scopeメソッドでタイトルのあいまい検索をした場合' do
        it "検索キーワードを含むタスクが絞り込まれる" do
          # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
          expect(Task.title_search('name1')).to include(task)
          expect(Task.title_search('name3')).not_to include(second_task)
        end
      end
      context 'scopeメソッドでステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          # ここに内容を記載する
          expect(Task.priority_search(2)).to include(task)
          expect(Task.priority_search(0)).not_to include(second_task)
        end
      end
      context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          expect(Task.title_search('1').priority_search(2)).to include(task)
          expect(Task.title_search('2').priority_search(2)).not_to include(second_task)
          expect(Task.title_search('3').priority_search(0)).not_to include(task)
          # expect(Task.priority_search('着手')).to include(task)
          # expect(Task.priority_search('未着手')).not_to include(second_task)
        end
      end
    end
  end
