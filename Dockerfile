FROM ubuntu
RUN apt-get update
# main installs
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get install -y gdb python3 python3-pip build-essential curl tmux vim sudo apt-transport-https ca-certificates gnupg
# gef
RUN bash -c "$(curl -fsSL http://gef.blah.cat/sh)"
RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf |  sh -s -- -y
RUN python3 -m pip install cffi pwntools
RUN echo "export LC_CTYPE=C.UTF-8" >> ~/.bashrc
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get --fix-missing update && apt-get -y install google-cloud-sdk
RUN sudo dpkg --add-architecture i386
RUN sudo apt-get update
RUN sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
CMD ["/bin/bash"]
