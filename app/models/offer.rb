class Offer < ActiveRecord::Base
 validates :code, uniqueness: true, presence: true
 #validates :deadline, 
end
