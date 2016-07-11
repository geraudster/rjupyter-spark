FROM geraudster/rjupyter
MAINTAINER geraudster

USER root
COPY spark* /cache/
RUN if [ ! -f /cache/spark-1.6.1-bin-hadoop2.4.tgz ]; then \
    mkdir -p /cache && \
    cd /cache && \
    wget http://apache.crihan.fr/dist/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.4.tgz; \
    fi

RUN mkdir -p /opt/spark && \
    cd /opt/spark && \
    tar xvzf /cache/spark-*.tgz

USER jupyter
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set SPARK env variables
ENV SPARK_HOME /opt/spark/spark-1.6.1-bin-hadoop2.4
ENV SPARKR_SUBMIT_ARGS --packages com.databricks:spark-csv_2.11:1.3.0 sparkr-shell
ENV R_LIBS_SITE $R_LIBS_SITE:$SPARK_HOME/R/lib
WORKDIR /data/jupyter/

