FROM archlinux/base
COPY ./scripts/container_setup.sh /container_setup.sh
COPY local_user /local_user
RUN bash /container_setup.sh 
