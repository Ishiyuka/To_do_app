class Task < ApplicationRecord
  validates :list, presence: true
  validates :detail, presence: true


  enum status:{未着手: 0, 進行中: 1, 完了: 2 }
  enum priority:{高: 0, 中: 1, 低: 2 }
  scope :created_list, ->{order(created_at: :desc)}
  scope :deadline_list, ->{order(deadline: :desc)}
  scope :priority_list, ->{order(priority: :asc)}
  scope :search_list_status, ->(list,status) { where("list LIKE ? ", "%#{list}%").where(status:status) }
  scope :search_list, ->(list) { where("list LIKE(?) ", "%#{list}%") }
  scope :search_status, ->(status) {where(status:status)}
end
