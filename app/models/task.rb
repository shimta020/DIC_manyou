class Task < ApplicationRecord
  validates :title, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 255}
  validates :deadline, presence: true
  validates :status, presence: true

  enum status:[:未着手, :着手中, :完了]

  scope :dead_limit, -> { order(deadline: :desc) }
  scope :search_title, -> (title) { where(["title like ?","%#{title}%"]) }
  scope :search_status, -> (status) { where(status: status) }

end
