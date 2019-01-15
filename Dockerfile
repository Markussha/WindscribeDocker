FROM ubuntu

#install dumb-init
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64
RUN chmod +x /usr/local/bin/dumb-init

#update system
RUN apt -y update
RUN apt -y upgrade

#install windscribe-cli
RUN echo 'deb https://repo.windscribe.com/ubuntu zesty main' | sudo tee /etc/apt/sources.list.d/windscribe-repo.list
RUN apt -y update
RUN apt -y install windscribe-cli

#install transmission
RUN apt -y install transmission-daemon

#only allow vpn connections
#Todo

#run dumb-init
ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

#start vpn
EXPOSE 9091
EXPOSE 8888
CMD ["windscribe","connect"]
#start transmission
CMD ["/usr/bin/transmission-daemon"]

