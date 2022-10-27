class Task < ApplicationRecord
  validates :list, presence: true
  validates :detail, presence: true
end
