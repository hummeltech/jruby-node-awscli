FROM jruby:1.7.26

ENV SHELL=/bin/bash

# Install nodejs, build-essential, git, python-pip, libpython-dev, libyaml-dev, xz-utils, nvm, avn and awscli
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get install -y nodejs build-essential git python-pip libpython-dev libyaml-dev xz-utils
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
RUN npm install --global avn avn-nvm webpack
RUN avn setup
RUN pip install --upgrade --user awscli
RUN cat ~/.bash_profile >> ~/.bashrc
RUN echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc
RUN echo 'eval $(grep -e aws_access_key_id -e aws_secret_access_key  ~/.aws/credentials | sed "s/ //g" | sed "s/aws_access_key_id/export AWS_ACCESS_KEY_ID/g" | sed "s/aws_secret_access_key/export AWS_SECRET_ACCESS_KEY/g")' >> ~/.bashrc
RUN rm -rf /var/lib/apt/lists/*
