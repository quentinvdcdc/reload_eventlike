class Event < ApplicationRecord
	validates :start_date,
		presence: true
	validates :duration,
		presence: true,
		numericality: { only_integer: true, greater_than: 0 }
	validates :title,
		presence: true,
		length:  { in: 5..140 }
	validates :description,
		presence: true,
		length:  { in: 20..1000 }
	validates :price,
		presence: true,
		numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
	validates :location,
		presence: true
	validate :is_created_in_the_future?,
		:is_multiple_of_five?

	belongs_to :administrator, class_name: "User"
	has_many :attendances, foreign_key: 'attended_event_id', class_name: "Attendance"
	has_many :attendees, through: :attendances

	private

	def is_created_in_the_future?
		errors.add(:start_date, "should be in the future") unless Time.now < self.start_date
	end

	def is_multiple_of_five?
		errors.add(:duration, "should be multiple of 5") unless self.duration % 5 == 0
	end
end
