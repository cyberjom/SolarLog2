#!/usr/bin/env ruby
require File.expand_path('../../config/environment', __FILE__)
require 'awesome_print'

pv = Hash.new
pv_uuid = Hash.new
pv_string = Hash.new

File.open('./script/TSS_pv.csv', 'r') do |f1|
  f1.gets
  while line = f1.gets
    tmp = line.split(',')
    uuid = tmp[12].to_i
    pvstring = tmp[14].chomp! unless tmp[14].nil?
    pv[tmp[2]] = tmp
    pv_uuid[uuid] = tmp[2]
    unless pvstring.nil?
      pv_string[pvstring.to_sym] = Array.new if pv_string[pvstring.to_sym].nil?
      pv_string[pvstring.to_sym].push tmp
    end
  end
end

pv_model = PvModel.first

pv_string.each_pair do |k,v|
  if k && k.length > 0
    string_rec = PvString.where(label: k,project_id: 10).first_or_initialize
    string_rec.module_count =  pv_string[k].count
    string_rec.pmax = 0
    string_rec.voc = 0
    string_rec.isc = 99.999
    string_rec.vpm = 0
    string_rec.ipm = 99.999
    string_rec.efficiency = 0
    string_rec.tc_pmax = 0
    string_rec.tc_voc = 0
    string_rec.tc_vmp = 0
    string_rec.tc_isc = 0
    string_rec.width = 0
    string_rec.height = 0
    string_rec.weight = 0
    string_rec.collection_area = 0
    string_rec.mppt_channel = 2 if ['N78','N80','S78','S82','S80','S84'].include?(k.to_s)
    string_rec.save
  else
    string_rec = nil
  end

  v.each do |m|
    module_rec = PvModule.where(serial_no: m[2], project_id: 10).first_or_initialize
    module_rec.pv_model_id = pv_model.id
    module_rec.pallet_no = m[1].to_i
    module_rec.pmax = m[3].to_i
    module_rec.voc = m[4].to_f      
    module_rec.isc = m[5].to_f   
    module_rec.ipm = m[6].to_f      
    module_rec.vpm = m[7].to_f
    module_rec.ff = m[8].to_f
    module_rec.uuid  = m[12]
    if string_rec
      module_rec.pv_string_id = string_rec.id
      string_rec.inverter_id  = m[13].to_i
      string_rec.voc += module_rec.voc
      string_rec.isc = module_rec.isc if string_rec.isc > module_rec.isc
      string_rec.vpm += module_rec.vpm
      string_rec.ipm = module_rec.ipm if string_rec.ipm > module_rec.ipm
      string_rec.pv_model_id = pv_model.id
      string_rec.tc_pmax = pv_model.tc_pmax
      string_rec.tc_voc = pv_model.tc_voc
      string_rec.tc_vmp = pv_model.tc_vmp
      string_rec.tc_isc = pv_model.tc_isc
      string_rec.width = pv_model.width
      string_rec.height = pv_model.height
      string_rec.weight += pv_model.weight 
      string_rec.collection_area += pv_model.height*pv_model.width
    end
    module_rec.save
    # ap module_rec
  end
  if string_rec
    string_rec.pmax = (string_rec.vpm*string_rec.ipm).round(2)
    string_rec.efficiency = (string_rec.pmax/string_rec.collection_area/1000).round(4)
    string_rec.collection_area = string_rec.collection_area.round(2)
    # ap string_rec
    string_rec.save
  end
end

sheet = Array.new
count = 0
File.open('./script/TSS_pv_location.csv', 'r') do |f1|
  while line = f1.gets
    sheet[count] = line.split(',')
    count += 1
  end
end

map = { :N01 => {:dir => :down,:start => [3,3]},
        :N02 => {:dir => :down,:start => [3,4]},
        :N03 => {:dir => :down,:start => [3,5]},
        :N04 => {:dir => :down,:start => [3,6]},
        :N05 => {:dir => :down,:start => [3,7]},
        :N06 => {:dir => :down,:start => [3,8]},
        :N07 => {:dir => :down,:start => [3,9]},
        :N08 => {:dir => :down,:start => [3,10]},
        :N09 => {:dir => :down,:start => [3,12]},
        :N10 => {:dir => :down,:start => [3,13]},
        :N11 => {:dir => :down,:start => [3,14]},
        :N12 => {:dir => :down,:start => [3,15]},
        :N13 => {:dir => :down,:start => [3,16]},
        :N14 => {:dir => :down,:start => [3,17]},
        :N15 => {:dir => :down,:start => [3,18]},
        :N16 => {:dir => :down,:start => [3,19]},
        :N17 => {:dir => :down,:start => [3,21]},
        :N18 => {:dir => :down,:start => [3,22]},
        :N19 => {:dir => :down,:start => [3,23]},
        :N20 => {:dir => :down,:start => [3,24]},
        :N21 => {:dir => :down,:start => [3,25]},
        :N22 => {:dir => :down,:start => [3,26]},
        :N23 => {:dir => :down,:start => [3,27]},
        :N24 => {:dir => :down,:start => [3,28]},
        :N25 => {:dir => :down,:start => [3,29]},
        :N26 => {:dir => :down,:start => [3,31]},
        :N27 => {:dir => :down,:start => [3,32]},
        :N28 => {:dir => :down,:start => [3,33]},
        :N29 => {:dir => :down,:start => [3,34]},
        :N30 => {:dir => :down,:start => [3,35]},
        :N31 => {:dir => :down,:start => [3,36]},
        :N32 => {:dir => :down,:start => [3,37]},
        :N33 => {:dir => :down,:start => [3,38]},
        :N34 => {:dir => :down,:start => [3,39]},        
        :N35 => {:dir => :down,:start => [3,41]},
        :N36 => {:dir => :down,:start => [3,42]},
        :N37 => {:dir => :down,:start => [3,43]},
        :N38 => {:dir => :down,:start => [3,44]},
        :N39 => {:dir => :down,:start => [3,45]},
        :N40 => {:dir => :down,:start => [3,46]},
        :N41 => {:dir => :down,:start => [3,47]},
        :N42 => {:dir => :down,:start => [3,48]},
        :N43 => {:dir => :down,:start => [3,49]},
        :N44 => {:dir => :down,:start => [3,51]},
        :N45 => {:dir => :down,:start => [3,52]},
        :N46 => {:dir => :down,:start => [3,53]},
        :N47 => {:dir => :down,:start => [3,54]},
        :N48 => {:dir => :down,:start => [3,55]},
        :N49 => {:dir => :down,:start => [3,56]},
        :N50 => {:dir => :down,:start => [3,57]},
        :N51 => {:dir => :down,:start => [3,58]},
        :N52 => {:dir => :down,:start => [3,59]},
        :N53 => {:dir => :right,:start => [16,3]},
        :N57 => {:dir => :right,:start => [17,3]},
        :N61 => {:dir => :right,:start => [18,3]},
        :N65 => {:dir => :right,:start => [19,3]},
        :N69 => {:dir => :right,:start => [20,3]},
        :N73 => {:dir => :right,:start => [21,3]},
        :N77 => {:dir => :right,:start => [22,3]},
        :N54 => {:dir => :right,:start => [16,17]},
        :N58 => {:dir => :right,:start => [17,17]},
        :N62 => {:dir => :right,:start => [18,17]},
        :N66 => {:dir => :right,:start => [19,17]},
        :N70 => {:dir => :right,:start => [20,17]},
        :N74 => {:dir => :right,:start => [21,17]},
        :N78 => {:dir => :right,:start => [22,17]},                      
        :N55 => {:dir => :right,:start => [16,32]},
        :N59 => {:dir => :right,:start => [17,32]},
        :N63 => {:dir => :right,:start => [18,32]},
        :N67 => {:dir => :right,:start => [19,32]},
        :N71 => {:dir => :right,:start => [20,32]},
        :N75 => {:dir => :right,:start => [21,32]},
        :N79 => {:dir => :right,:start => [22,32]},
        :N56 => {:dir => :right,:start => [16,46]},
        :N60 => {:dir => :right,:start => [17,46]},
        :N64 => {:dir => :right,:start => [18,46]},
        :N68 => {:dir => :right,:start => [19,46]},
        :N72 => {:dir => :right,:start => [20,46]},
        :N76 => {:dir => :right,:start => [21,46]},
        :N80 => {:dir => :right,:start => [22,46]},         
        :S01 => {:dir => :up,:start => [49,3]},
        :S02 => {:dir => :up,:start => [49,4]},
        :S03 => {:dir => :up,:start => [49,5]},
        :S04 => {:dir => :up,:start => [49,6]},
        :S05 => {:dir => :up,:start => [49,7]},
        :S06 => {:dir => :up,:start => [49,8]},
        :S07 => {:dir => :up,:start => [49,9]},
        :S08 => {:dir => :up,:start => [49,10]},
        :S09 => {:dir => :up,:start => [49,12]},
        :S10 => {:dir => :up,:start => [49,13]},
        :S11 => {:dir => :up,:start => [49,14]},
        :S12 => {:dir => :up,:start => [49,15]},
        :S13 => {:dir => :up,:start => [49,16]},
        :S14 => {:dir => :up,:start => [49,17]},
        :S15 => {:dir => :up,:start => [49,18]},
        :S16 => {:dir => :up,:start => [49,19]},
        :S17 => {:dir => :up,:start => [49,21]},
        :S18 => {:dir => :up,:start => [49,22]},
        :S19 => {:dir => :up,:start => [49,23]},
        :S20 => {:dir => :up,:start => [49,24]},
        :S21 => {:dir => :up,:start => [49,25]},
        :S22 => {:dir => :up,:start => [49,26]},
        :S23 => {:dir => :up,:start => [49,27]},
        :S24 => {:dir => :up,:start => [49,28]},
        :S25 => {:dir => :up,:start => [49,29]},
        :S26 => {:dir => :up,:start => [49,31]},
        :S27 => {:dir => :up,:start => [49,32]},
        :S28 => {:dir => :up,:start => [49,33]},
        :S29 => {:dir => :up,:start => [49,34]},
        :S30 => {:dir => :up,:start => [49,35]},
        :S31 => {:dir => :up,:start => [49,36]},
        :S32 => {:dir => :up,:start => [49,37]},
        :S33 => {:dir => :up,:start => [49,38]},
        :S34 => {:dir => :up,:start => [49,39]},        
        :S35 => {:dir => :up,:start => [49,41]},
        :S36 => {:dir => :up,:start => [49,42]},
        :S37 => {:dir => :up,:start => [49,43]},
        :S38 => {:dir => :up,:start => [49,44]},
        :S39 => {:dir => :up,:start => [49,45]},
        :S40 => {:dir => :up,:start => [49,46]},
        :S41 => {:dir => :up,:start => [49,47]},
        :S42 => {:dir => :up,:start => [49,48]},
        :S43 => {:dir => :up,:start => [49,49]},
        :S44 => {:dir => :up,:start => [49,51]},
        :S45 => {:dir => :up,:start => [49,52]},
        :S46 => {:dir => :up,:start => [49,53]},
        :S47 => {:dir => :up,:start => [49,54]},
        :S48 => {:dir => :up,:start => [49,55]},
        :S49 => {:dir => :up,:start => [49,56]},
        :S50 => {:dir => :up,:start => [49,57]},
        :S51 => {:dir => :up,:start => [49,58]},
        :S52 => {:dir => :up,:start => [49,59]},
        :S53 => {:dir => :right,:start => [36,3]},
        :S57 => {:dir => :right,:start => [35,3]},
        :S61 => {:dir => :right,:start => [34,3]},
        :S65 => {:dir => :right,:start => [33,3]},
        :S69 => {:dir => :right,:start => [32,3]},
        :S73 => {:dir => :right,:start => [31,3]},
        :S77 => {:dir => :right,:start => [30,3]},
        :S81 => {:dir => :right,:start => [29,3]},        
        :S54 => {:dir => :right,:start => [36,17]},
        :S58 => {:dir => :right,:start => [35,17]},
        :S62 => {:dir => :right,:start => [34,17]},
        :S66 => {:dir => :right,:start => [33,17]},
        :S70 => {:dir => :right,:start => [32,17]},
        :S74 => {:dir => :right,:start => [31,17]},
        :S78 => {:dir => :right,:start => [30,17]},
        :S82 => {:dir => :right,:start => [29,17]},        
        :S55 => {:dir => :right,:start => [36,32]},
        :S59 => {:dir => :right,:start => [35,32]},
        :S63 => {:dir => :right,:start => [34,32]},
        :S67 => {:dir => :right,:start => [33,32]},
        :S71 => {:dir => :right,:start => [32,32]},
        :S75 => {:dir => :right,:start => [31,32]},
        :S79 => {:dir => :right,:start => [30,32]},
        :S83 => {:dir => :right,:start => [29,32]},        
        :S56 => {:dir => :right,:start => [36,46]},
        :S60 => {:dir => :right,:start => [35,46]},
        :S64 => {:dir => :right,:start => [34,46]},
        :S68 => {:dir => :right,:start => [33,46]},
        :S72 => {:dir => :right,:start => [32,46]},
        :S76 => {:dir => :right,:start => [31,46]},
        :S80 => {:dir => :right,:start => [30,46]},
        :S84 => {:dir => :right,:start => [29,46]}
      }
      
      
pv_order = Hash.new
map.each do |key, val|
  # puts "==== #{key} ===="
  pv_order[key] = Array.new
  case val[:dir]
  when :down
    row, col = val[:start]
    (0..12).each do |i|
       pv_order[key].push sheet[row+i][col].to_i
    end
    # p pv_order[key]
  when :up
    row, col = val[:start]
    (0..12).each do |i|
       pv_order[key].push sheet[row-i][col].to_i
    end
    # p pv_order[key]
  when :right
    row, col = val[:start]
    i = 0
    while pv_order[key].size < 13
       pv_order[key].push sheet[row][col+i].to_i unless sheet[row][col+i] == ""
       i += 1
    end
    # p pv_order[key]
  end
end

# ap pv_order

pv_order.each_pair do |k,v|
  pv_string_rec = PvString.where(label: k.to_s,project_id: 10).first
  ap pv_string_rec
  count = 0
  v.each do |uid|
    pv_module_rec = PvModule.where(uuid: uid.to_s.rjust(4, "0"),project_id: 10, active_flag: true).first
    rec = PvLocation.where(pv_string_id: pv_string_rec.id, pv_module_id: pv_module_rec.id,project_id: 10).first_or_initialize
    rec.order = count
    rec.save
    count += 1
  end
end