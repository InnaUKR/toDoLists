class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy
  default_scope -> { order('created_at') }
  validates :user_id, presence: true
  validates :title, presence: true
  accepts_nested_attributes_for :tasks
end