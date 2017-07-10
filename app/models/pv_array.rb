class PvArray < ApplicationRecord
  belongs_to :project
  has_many :pv_strings 
end
