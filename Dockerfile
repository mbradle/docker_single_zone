FROM mbradle/docker_wn_user

ENV NAME VAR

WORKDIR /my-projects

RUN git clone https://mbradle@bitbucket.org/mbradle/single_zone.git

WORKDIR /my-projects/single_zone

ARG DIRECTORY=/output_directory
ENV VAR_DIR=$DIRECTORY

RUN make single_zone_network
RUN make data

COPY run_single_zone.sh /my-projects/single_zone

CMD ["/bin/sh", "/my-projects/single_zone/run_single_zone.sh"]
