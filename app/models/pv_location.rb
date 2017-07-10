class PvLocation < ApplicationRecord
  has_many :pv_modules
  has_many :pv_strings  
end
