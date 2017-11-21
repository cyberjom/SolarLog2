# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Province.create!(symbol: 'กทม',  
                 symbol_en: 'BKK',
                 caption: 'กรุงเทพ', 
                 caption_en: 'Bangkok')
                 
pr = Province.create!(symbol: 'ปจ',  
                 symbol_en: 'PJ',
                 caption: 'ปราจีนบุรี', 
                 caption_en: 'Prachinburi')

InverterModel.create!(brand: 'ABB',
                name: 'TRIO50', 
                mppt_num: 1,
                pmax: 50000 
)
InverterModel.create!(brand: 'ABB',
                name: 'PVI10',
                mppt_num: 2,
                pmax: 11000 
)
                
PvModel.create!(brand: 'Panasonic',
                part_no: 'VBHN330SJ47',  
                pmax: 330,
                voc: 69.7,
                isc: 6.07,
                vpm: 58,
                ipm: 5.7,
                efficiency: 0.197,
                tc_pmax: -0.258,
                tc_voc: -0.174,
                tc_vmp: 0,
                tc_isc: 1.82,
                width: 1.053,
                height: 1.590,
                weight: 18.5)
                
Customer.create!(symbol: "InterSol")
tss = Customer.create!(symbol: "TSS", caption: "บริษัท ไทยสเตนเลสสตีล จำกัด", caption_en: "Thai Stainless Steel Co., Ltd.")
tss.projects.create!(caption: "Factory 703kW", 
                     capacity: 330*2132,    
                     scod: "2017-03-31",
                     cod: "2017-05-20",
                     latitude: 13.975865,   
                     longitude: 100.212272,
                     billing_cycle: 1)



# tarif rate A, B, C
# type = 4.2,
# ft = {
#   Y2017: [-0.3729,-0.3729,-0.3729,-0.3729,-0.2477,-0.2477,-0.2477,-0.2477,-0.2477,-0.2477,-0.2477,-0.2477]
# },
# off_peak_holiday = {
#   Y2017: ["6-04", "13-04", "14-04", "1-05", "5-05", "10-05", "23-05", "5-12"]
# },
# hour_rate = ["O","O","O","O","O","O","O","O","O","P","P","P","P","P","P","P","P","P","P","P","P","P","O","O"]



