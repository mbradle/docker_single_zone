FROM mbradle/docker_wn_user

ENV NAME VAR
ENV NAME HEADER_COPY_DIRECTORY

WORKDIR /my-projects

RUN git clone https://mbradle@bitbucket.org/mbradle/single_zone.git

WORKDIR /my-projects/single_zone

ARG INPUT_DIRECTORY=/input_directory
ENV IN_VAR_DIR=$INPUT_DIRECTORY

ARG OUTPUT_DIRECTORY=/output_directory
ENV OUT_VAR_DIR=$OUTPUT_DIRECTORY

COPY run_single_zone.sh master.[h] /my-projects/single_zone/

RUN make single_zone_network
RUN make data

CMD ["/bin/sh", "/my-projects/single_zone/run_single_zone.sh"]
