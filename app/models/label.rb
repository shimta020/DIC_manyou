class Label < ApplicationRecord
  has_many :label_tasks, dependent: :destroy
  has_many :tasks, through: :label_tasks
  validates :label_name, presence: true, length: {maximum: 10}
end
