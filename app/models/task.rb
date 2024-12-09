class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    validates :deadline_on, presence: true
    validates :priority, presence: true
    validates :status, presence: true


    enum priority: {
        low: "0",
        medium: "1",
        high: "2" 
    }
    enum status:{
        "Not Started": "0",
        "In Process": "1",
        "Complete":"2"
    }

    scope :search_title, -> title {where("title LIKE ?", "%#{title}%")}
    scope :search_status, -> status {where(status: status)}
    scope :order_by_created_at, -> {order(created_at: :desc,id: :desc)}
    scope :order_by_deadline, -> {order(deadline_on: :asc)}
    scope :order_by_priority_asc, -> {order(priority: :asc,created_at: :desc)}
end
