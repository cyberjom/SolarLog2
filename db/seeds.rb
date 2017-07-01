# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

PvModel.create!(brand_id: 1,
                part_no: 'VBHN330SJ47',  
                pmax: 330,
                voc: 69.7,
                isc: 6.07,
                vpm: 58,
                ipm: 5.7,
                efficiency: 19.7,
                tc_pmax: -0.258,
                tc_voc: -0.174,
                tc_vmp: 0,
                tc_isc: 1.82,
                width: 1.053,
                height: 1.590,
                weight: 18.5)
                