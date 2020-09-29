FactoryBot.define do
  factory :task do
    title { 'テストタイトル１' }
    content { 'テストタスク１' }
    time_limit { '2020-09-21 12:00:00' }
    priority { 0 }
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :first_task, class: Task do
    title { 'name1' }
    content { 'content1' }
    time_limit { '2020-09-30 12:00:00' }
    priority { 2 }
    to_do { '高' }
  end
  factory :second_task, class: Task do
    title { 'name2' }
    content { 'content2' }
    time_limit { '2020-09-25 12:00:00' }
    priority { 1 }
    to_do { '中' }
  end
  factory :third_task, class: Task do
    title { 'name3' }
    content { 'content3' }
    time_limit { '2020-09-28 12:00:00' }
    priority { 0 }
    to_do { '低' }
  end
end
