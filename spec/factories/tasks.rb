FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :first_task, class: Task do
    title { 'name1' }
    content { 'content1' }
  end
  factory :second_task, class: Task do
    title { 'name2' }
    content { 'content2' }
  end
  factory :third_task, class: Task do
    title { 'name3' }
    content { 'content3' }
  end
end
