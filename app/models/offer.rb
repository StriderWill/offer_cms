class Offer < ActiveRecord::Base
 validates :code, uniqueness: true, presence: true,
 	format: { with: /\[with0-9A-Z]{8}$\z/,
 	message: "Offer code must be 8 characters using capital letters and numbers"}
 #validates :deadline, 
end
