class User < ApplicationRecord
  has_secure_password 
  after_create -> { Rails.logger.info("New User created!") }
  before_save { self.email = email.downcase }
  before_destroy :prevent_last_admin_deletion
  before_update :prevent_last_admin_demotion


  validates :name, presence: true
  validates :password, presence: true,length: { minimum: 6 },:if => :password_is_present?
  validates :password_confirmation, presence: true,:if => :password_is_present?
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,uniqueness: { case_sensitive: false },length: { maximum: 105 },format: { with: VALID_EMAIL_REGEX }


  has_many :tasks, dependent: :destroy 
  def admin_privilege
    admin ? 'Oui' : "Aucun" 
  end


  # after_destroy :delete_dependent_tasks

  #   private

  #     def delete_dependent_tasks
  #           tasks.each do |task|
  #               task.destroy
  #           end
  #     end
  private
    def password_is_present?
      password.present?
    end
    def prevent_last_admin_deletion
      if admin && User.where(admin: :true).count == 1
        errors.add(:base, "The user cannot be deleted because there are zero administrators")
        throw(:abort)
      end
    end
    def prevent_last_admin_demotion
      if admin_was && !admin && User.where(admin: true).count == 1
        errors.add(:base, "The privileges cannot be changed because there are zero administrators")
        throw(:abort)
      end
    end
end
