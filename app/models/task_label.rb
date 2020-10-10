class TaskLabel < ApplicationRecord
  belongs_to :task
  belongs_to :label
  # scope :label_search, ->(params) { where(label_id: params) }
end
