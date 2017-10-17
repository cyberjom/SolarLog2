#!/bin/bash

rake db:drop
rake db:create
rake db:migrate
rake db:seed
./script/TSS_seed.rb
./script/TC_seed.rb
