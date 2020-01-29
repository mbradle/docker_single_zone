# docker_single_zone
Webnucleo single zone docker

<!--
Tags:

- default: made with default master.h
-->

Steps to build and run the docker image.

First clone the repository:

- git clone http://github.com/mbradle/docker_single_zone

Now build the image:

- cd docker_single_zone
- docker build -t single_zone .

Now create a directory for the input and output:

- mkdir work
- mkdir work/input
- mkdir work/output
- cp input/run.rsp to work/input/

Now download the necessary data.  First, record the current location:

- pwd

Replace PWD in the instructions below with the string that is returned by
this command.  Now download the data:

- docker run -it -v PWD/work/input/data_pub:/data_directory -e VAR=data webnucleo/data_downloadd

Now edit work/input/run.rsp.  Note that input can also be input through the VAR, as in the next step.

Run the calculation.  For example:

- docker run -it -v PWD/work/input:/input_directory -v PWD/work/output:/output_directory -e VAR=@/input_directory/run.rsp single_zone

The output will be in the directory work/output.  One can add options into the response file run.rsp or directly into the command line:

- docker run -it -v PWD/work/input:/input_directory -v PWD/work/output:/output_directory -e VAR="@/input_directory/run.rsp --tend 1." single_zone

This calculation cuts of the expansion after 1 second instead of the default 1.e6 seconds.

<!--
To compile with a different master.h, first get the master.h:

- docker run -it -v PWD/work/input:/input_directory -v PWD/work/output:/output_directory -e HEADER_COPY_DIRECTORY=/output_directory single_zone

Copy the master.h to this directory:

- cp work/output/master.h .

Edit master.h.  Now rebuild, but set the WN_USER flag:

- docker build -t single_zone --build-arg WN_USER=1 .

Edit work/input/run.rsp appropriately.  Then run as before.
-->
