#!/bin/sh

./single_zone_network \
   --tau 0.1  \
   --network_xml ../nucnet-tools-code/data_pub/my_net.xml  \
   --iterative_solver gmres \
   --iterative_t9 2  \
   --nuc_xpath "[z <= 20]" \
   --output_xml ${VAR_DIR}/out1.xml  \
   --init_mass_frac "{h1, 0.5}" "{n, 0.5}" \
   $VAR
