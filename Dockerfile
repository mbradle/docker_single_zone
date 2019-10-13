FROM mbradle/docker_wn_user

ENV NAME VAR

WORKDIR /my-projects

RUN git clone https://mbradle@bitbucket.org/mbradle/single_zone.git

WORKDIR /my-projects/single_zone

ARG INPUT_DIRECTORY=/input_directory
ENV IN_VAR_DIR=$INPUT_DIRECTORY

ARG OUTPUT_DIRECTORY=/output_directory
ENV OUT_VAR_DIR=$OUTPUT_DIRECTORY

RUN make single_zone_network
RUN make data

COPY run_single_zone.sh /my-projects/single_zone

CMD ["/bin/sh", "/my-projects/single_zone/run_single_zone.sh"]
