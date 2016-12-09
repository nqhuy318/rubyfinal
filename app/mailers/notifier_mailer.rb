class NotifierMailer < ApplicationMailer
	default :from => 'nhom635@gmail.com'

	def send_join_to_freelancer freelancer, customer
		@freelancer = freelancer
		@customer = customer
		mail to: @freelancer.email, subject: "You have joined a work"
	end

	def send_join_to_customer freelancer, customer
		@freelancer = freelancer
		@customer = customer
		mail to: @customer.email, subject: "A freelancer just join your work"
end
