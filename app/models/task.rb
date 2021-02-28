class Task < ApplicationRecord
  validates :title, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 255}
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  enum status:[:未着手, :着手中, :完了]
  enum priority:[:低, :中, :高]

  scope :sort_deadline, -> { order(deadline: :desc) }
  scope :sort_priority, -> { order(priority: :desc) }
  scope :search_title, -> (title) { where(["title like ?","%#{title}%"]) }
  scope :search_status, -> (status) { where(status: status) }

  belongs_to :user
end
