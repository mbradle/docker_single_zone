FROM mbradle/docker_wn_user

ENV NAME VAR
ENV NAME HEADER_COPY_DIRECTORY

ARG WN_USER
ENV WN_USER=$WN_USER

WORKDIR /my-projects

RUN git -C ${WN_USER_TARGET} pull

RUN git clone https://mbradle@bitbucket.org/mbradle/single_zone.git

WORKDIR /my-projects/single_zone

COPY master.[h] /my-projects/single_zone/

RUN make single_zone_network

CMD if [ "$HEADER_COPY_DIRECTORY" ]; then cp /my-projects/single_zone/default/master.h ${HEADER_COPY_DIRECTORY}/master.h; else ./single_zone_network $VAR ; fi
