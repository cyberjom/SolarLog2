class PvModule < ApplicationRecord
  belongs_to :pv_string
  belongs_to :pv_model
  belongs_to :project
  has_many :pv_locations
end
