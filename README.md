# docker_nnp_single_zone
Webnucleo single zone

Steps:

1) Run:  docker build -t single_zone .
2) Run:  mkdir work
3) Run:  mkdir work/input
4) Run:  mkdir work/output
5) Run:  input/run.rsp to work/input/
6) Edit work/input/run.rsp as desired.  Note that input can also be input through the VAR, as in the next step.
7) Run:  docker run -it -v `pwd`/work/input:/input_directory -v `pwd`/work/output:/output_directory -e VAR="--t9_0 5 --rho_0 1.e7" single_zone
