class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  scope :title_search, -> (params){ where('title like ?',"%#{params}%") }
  scope :priority_search, ->(params) { where(priority: params) }
  enum genre:{
   already: 0,
   not_yet: 1
 }
end
