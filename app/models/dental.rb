class Dental < ActiveRecord::Base
	belongs_to :phr

	validates :dentist, presence: true
	validates :date, presence: true
	validates :description, presence: true
end
