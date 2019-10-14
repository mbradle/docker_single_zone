# docker_nnp_single_zone
Webnucleo single zone docker

Tags:

- default: made with default master.h

To build docker images:

- docker build -t single_zone .
- mkdir work
- mkdir work/input
- mkdir work/output
- cp input/run.rsp to work/input/

Now edit work/input/run.rsp.  Note that input can also be input through the VAR, as in the next step.

Run the calculation.  For example:

- docker run -it -v `pwd`/work/input:/input_directory -v `pwd`/work/output:/output_directory -e VAR="--t9_0 5 --rho_0 1.e7" single_zone

To compile with a different master.h, first get the master.h:

- docker run -it -v `pwd`/work/input:/input_directory -v `pwd`/work/output:/output_directory -e VAR="--t9_0 5 --rho_0 1.e7" -e HEADER_COPY_DIRECTORY=/output_directory single_zone

Copy the master.h to this directory:

- cp work/output/master.h .

Edit master.h.  Now rebuild, but set the WN_USER flag:

- docker build -t single_zone --build-arg WN_USER=1 .

Edit work/input/run.rsp appropriately.  Then run as before.
