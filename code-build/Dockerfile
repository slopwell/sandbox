FROM aws/codebuild/standard:7.0

RUN apt update 
RUN echo Installing basical commands... && \
    apt-get install git -y && \
    apt-get install curl -y && \
    apt-get install unzip -y

RUN echo Installing dependencies... && \
    npm install

RUN echo Installing tfenv... && \
    git clone --depth=1 https://github.com/tfutils/tfenv.git $HOME/.tfenv && \
    echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> $HOME/.bashrc && \
    source $HOME/.bashrc

RUN curl -Ls -o terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/v0.48.0/terragrunt_linux_amd64 && \
    mv terragrunt /usr/local/bin/terragrunt && \
    chown root:root /usr/local/bin/terragrunt && \
    chmod 555 /usr/local/bin/terragrunt && \
    terragrunt --version