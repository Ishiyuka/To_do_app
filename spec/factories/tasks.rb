# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    list { 'Factoryで作ったデフォルトのタスク1' }
    detail { 'Factoryで作ったデフォルトの詳細1' }
    deadline {"2022-11-01"}
    status {'未着手'}
    priority {"高"}
  end

  factory :second_task, class: Task do
    list { 'Factoryで作ったデフォルトのタスク2' }
    detail { 'Factoryで作ったデフォルトの詳細2' }
    deadline {"2022-11-11"}
    status {"着手中"}
    priority {"中"}
  end

  factory :third_task, class: Task do
    list { 'Factoryで作ったデフォルトのタスク3' }
    detail { 'Factoryで作ったデフォルトの詳細3' }
    deadline {"2022-11-31"}
    status {"完了"}
    priority {"低"}
  end

end
