class Offer < ActiveRecord::Base
 validates :offer_code, uniqueness: true

end
