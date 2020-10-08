class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  scope :title_search, -> (params){ where('title like ?',"%#{params}%") }
  scope :priority_search, ->(params) { where(priority: params) }
 #  enum to_do: {
 #    low: 0,
 #    medium: 1,
 #    high: 2
 #  }
 #  enum priority:{
 #   already: 0,
 #   not_yet: 1
 # }
has_many :task_labels, dependent: :destroy
has_many :labels, through: :task_labels
 enum priority: %i[未着手 着手中 完了]
 enum to_do: %i[高 中 低]
end
