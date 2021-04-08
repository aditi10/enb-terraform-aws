#!/bin/bash

replace=$1

cp kafka_service_role_policy.tf $1"_service_role_policy.tf"
sed -ie "s/kafka/${replace}/g" $1"_service_role_policy.tf"
cp kafka_service_role.tf $1"_service_role.tf"
sed -ie "s/kafka/${replace}/g" $1"_service_role.tf"
rm -rf $1"_service_role_policy.tfe"
rm -rf $1"_service_role.tfe"
#echo "hello" $1
