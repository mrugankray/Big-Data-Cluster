FROM bde2020/hadoop-resourcemanager:2.0.0-hadoop3.2.1-java8

LABEL maintainer="mrugankray@gmail.com"
LABEL description="container acting as resourcemanager & python installed"

# set the env variables
ENV PATH=/root/anaconda/bin:$PATH

# install packages in /usr/lib/sqoop
WORKDIR /

# installing mini conda
RUN curl -O https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh && mv Mini* miniconda.sh && bash miniconda.sh -b -u -p ~/anaconda && conda update conda -y && rm miniconda.sh && conda install conda-pack -y

EXPOSE 8042

# start resourcemanager
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/run.sh"]