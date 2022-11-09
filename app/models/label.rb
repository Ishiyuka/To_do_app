class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :tasks, through: :labellings

  scope :id_is, -> id {
    where(id: id)
  }
end
