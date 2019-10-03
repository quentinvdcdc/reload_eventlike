class User < ApplicationRecord
	validates :first_name,
		presence: true
	validates :last_name,
		presence: true
	validates :description,
		presence: true,
		length:  { in: 20..1000 }
	validates :email,
		presence: true,
		uniqueness: true,
		format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }
	validates :encrypted_password,
		presence: true

	has_many :administrated_events, foreign_key: 'administrator_id', class_name: "Event"
	has_many :attendances, foreign_key: 'attendee_id', class_name: "Attendance"
	has_many :attended_events, through: :attendances
end
