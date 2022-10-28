# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    # list { 'test_list' }
    list { 'Factoryで作ったデフォルトのタスク1' }
    # detail { 'test_detail' }
    detail { 'Factoryで作ったデフォルトの詳細1' }
  end
end
