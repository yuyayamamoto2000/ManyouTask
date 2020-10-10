class Task < ApplicationRecord
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  scope :title_search, -> (params){ where('title like ?',"%#{params}%") }
  scope :priority_search, ->(params) { where(priority: params) }
  scope :label_search, ->(params) { where(label_id: params) }
  # scope :label_search, ->(params) { where(labels: { id: params[:name] })}
  # scope :label_search, ->(params) { where(task_id: params) }

  enum priority: %i[未着手 着手中 完了]
  enum to_do: %i[高 中 低]

  validates :title, presence: true
  validates :content, presence: true
end
