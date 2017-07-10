class Project < ApplicationRecord
  belongs_to :customer
  has_one :electricity_provider
  has_many :inverters
  has_many :pv_arrays
  has_many :pv_modules
  has_many :pv_strings
end
