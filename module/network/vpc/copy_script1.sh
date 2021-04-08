#!/bin/bash

replace=$1

cp private_subnet.tf $1"_private_subnet.tf"
sed -ie "s/app_priv_subnet/${replace}_priv_subnet/g" $1"_private_subnet.tf"
sed -ie "s/api_rt/${replace}"_api_rt"/g" $1"_private_subnet.tf"
sed -ie "s/api_rt_natgw/${replace}"_api_rt_natgw"/g" $1"_private_subnet.tf"
sed -ie "s/api_rta/${replace}"_api_rta"/g" $1"_private_subnet.tf"
sed -ie "s/private_ranges/${replace}"_private_ranges"/g" $1"_private_subnet.tf"
rm *.tfe
echo "DONE"
