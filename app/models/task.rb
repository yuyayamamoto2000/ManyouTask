class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum genre:{
   already: 0,
   not_yet: 1
 }
end
