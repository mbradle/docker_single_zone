# docker_single_zone
This is the Webnucleo single-zone reaction network docker image repository.

# Steps to build and run the default docker image.

First clone the repository.  Type:

**git clone http://github.com/mbradle/docker_single_zone**

Now change into the cloned directory.  Type:

**cd docker_single_zone**

If you have previously cloned the repository, you can update by typing:

**git pull**

Now build the image.  Type:

**docker build -t single_zone:default .**

The docker image that gets built is *single_zone:default*.  The *:default* is a tag that allows you to distinguish other single zone images.  Of course you can provide your own name for both the image and the tag.

Now create a directory for the input and output.  Type:

**mkdir work**

**mkdir work/input**

**mkdir work/output**

**cp input/run.rsp work/input/**

Now download the necessary data.  First, record the current location.  Type

**pwd**

In the instructions below, you should simply be able to use the commands verbatim (most likely, you will simply cut and paste).  If that does not work, replace the *${PWD}* present with the string that is returned by the *pwd* command.  Now download the data.  Type:

**docker run -it -v ${PWD}/work/input/data_pub:/data_directory -e VAR=data webnucleo/data_download**

Now edit *work/input/run.rsp*.  Run the calculation.  For example, type:

**docker run -it -v ${PWD}/work/input:/input_directory -v ${PWD}/work/output:/output_directory -e VAR=@/input_directory/run.rsp single_zone:default**

The output will be in the directory *work/output*.  One can add options into the response file run.rsp or directly into the command line.  For example, type:

**docker run -it -v ${PWD}/work/input:/input_directory -v ${PWD}/work/output:/output_directory -e VAR="@/input_directory/run.rsp --tend 1." single_zone:default**

This calculation cuts off the expansion after 1 second instead of the default 1.e6 seconds.

Linux users may find they need to prepend *sudo* to run docker.  For example, they may need to type:

**sudo docker run -it -v ${PWD}/work/input/data_pub:/data_directory -e VAR=data webnucleo/data_download**

Here are some [notes](https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo) on running without *sudo* that may be of interest.

# Steps to list possible options or an example execution.

To get a help statement for a single-zone network docker image, type:

**docker run -e VAR=--help single_zone:default**

The output lists a usage statement for the underlying single-zone network code.  Any of the suggested commands can be entered as input through the *VAR* variable.  For example, you can type:

**docker run -e VAR=--example single_zone:default**

to get the example execution (of the underlying single-zone network code).  The options in the example execution would be added to the response file or the command line (through *VAR*).  To get the listing of all possible options, type:

**docker run -e VAR="--prog all" single_zone:default**

The input to *VAR* is between quotes to ensure that it is recognized as a single input string.  To get options for a particular class, select that class as input to the *program_options* option.  For example, type:

**docker run -e VAR="--prog network_time" single_zone:default**

# Steps to build with a different master.h file.

First, it's useful to prune any dangling containers by typing:

**docker system prune**

The command

**docker system prune -a**

will clear out everything and start over if you prefer.

Next, download the default *master.h* to the *$PWD* directory.  Type:

**docker run -it -v ${PWD}:/header_directory -e HEADER_COPY_DIRECTORY=/header_directory single_zone:default**

Edit *master.h*.  Now rebuild, but set the WN_USER flag:

**docker build -t single_zone:tag --build-arg WN_USER=1 .**

where *tag* is a tag to distinguish the new image from the default.  You can now edit work/input/run.rsp appropriately.  Then run as before using the new tag.

As an example, edit *master.h*.  In particular, change the lines in the file that read

     #include "hydro/single_zone/standard/detail/default.hpp"
     #include "hydro/single_zone/standard/hydro.hpp"

to instead read

     #include "hydro/single_zone/trajectory/detail/time_t9_rho.hpp"
     #include "hydro/single_zone/trajectory/hydro.hpp"
     
and then run

**docker build -t single_zone:time_t9_rho --build-arg WN_USER=1 .**

This new docker image will run a calculation in which the temperature and density are determined by interpolation from a file.  Create a file (call it *my_file.txt*) in the *work/input* directory that reads, for example

     0  10.  1.e8
     1  5.   1.e7
     2  5.   1.e7
     3  2.   1.e4
     4  2.   1.e4
     5  0.1  1.e2

This file gives the time (in seconds in column 1), the t9 (temperature in billions of K in column 2), and the density (in g/cc in column 3).  Now edit the file *work/input/run.rsp* to read

    --interp_file /input_directory/my_file.txt
    --network_xml /input_directory/data_pub/my_net.xml
    --nuc_xpath "[z <= 30]" --xml_steps 2
    --output_xml /output_directory/out.xml
    --init_mass_frac "{h1; 0.5}" "{n; 0.5}"

Now run the code by typing:

**docker run -it -v ${PWD}/work/input:/input_directory -v ${PWD}/work/output:/output_directory -e VAR="@/input_directory/run.rsp" single_zone:time_t9_rho**

# How to force a rebuild of one of your images.

If you suspect that the underlying code has been updated since your latest docker build, you can force a rebuild by using the *--no-cache* option.  For example, you can type:

**docker build --no-cache -t single_zone:default .**

This will force docker to pull any new changes to the underlying codes down before rebuilding.

# Using Docker Hub for your images.

Once you have an image that you would like to share with your collaborators, you can set up a repository on [Docker Hub](https://hub.docker.com).  You can push images to the repository that others can then pull down and use.  This [site](https://runnable.com/docker/using-docker-hub) provides more information.
