FROM mbradle/docker_wn_user

ENV NAME VAR
ENV NAME HEADER_COPY_DIRECTORY

ARG WN_USER
ENV WN_USER=$WN_USER

ARG INPUT_DIRECTORY=/input_directory
ARG OUTPUT_DIRECTORY=/output_directory

WORKDIR /my-projects

RUN git clone https://mbradle@bitbucket.org/mbradle/single_zone.git

WORKDIR /my-projects/single_zone

COPY run_single_zone.sh master.[h] /my-projects/single_zone/

RUN make single_zone_network

CMD ["/bin/sh", "/my-projects/single_zone/run_single_zone.sh"]
