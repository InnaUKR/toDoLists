class Task < ActiveRecord::Base
	belongs_to :project 
	default_scope -> { order('created_at') }
	validates :project_id, presence: true
  	validates :title, presence: true


	def completeda?
		complete==true
	end
end
