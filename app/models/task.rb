class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    validates :deadline_on, presence: true
    validates :priority, presence: true
    validates :status, presence: true


    enum priority: {
        Faible: 0,
        Moyenne: 1,
        Elevée: 2 
    }
    enum status:{
        "Non démarré": 0,
        "Démarré": 1,
        "Terminé":2
    }

    scope :search_title, -> title {where("title LIKE ?", "%#{title}%")}
    scope :search_status, -> status {where(status: status)}
    scope :order_by_created_at, -> {order(created_at: :desc,id: :desc)}
    scope :order_by_deadline, -> {order(deadline_on: :asc)}
    scope :order_by_priority_desc, -> {order(priority: :desc)}
end
