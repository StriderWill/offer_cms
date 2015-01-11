class Offer < ActiveRecord::Base
 validates :code, uniqueness: true, presence: true
end
