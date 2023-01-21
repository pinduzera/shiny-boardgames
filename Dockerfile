# get shiny serves plus tidyverse packages image
FROM rocker/shiny:latest

# system libraries of general use
RUN apt-get update && apt-get install -y \
sudo \
libcurl4-gnutls-dev \
libcairo2-dev \
libxt-dev \
libssl-dev \
libssh2-1-dev 

#Fix windows file EOL to linux 
RUN apt-get update && apt-get install -y dos2unix

# install R packages required 
# (change it dependeing on the packages you need)

RUN R -e "install.packages(c('shiny','shinyWidgets', \
          'data.table', 'lubridate', 'plotly', \
          'bslib' ))"

COPY shiny-server.sh /usr/bin/shiny-server.sh
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

# select port

# allow permission
RUN sudo chown -R shiny:shiny /srv/shiny-server
RUN sudo chown -R shiny:shiny /var/lib/shiny-server
RUN sudo chown -R shiny:shiny /usr/bin/shiny-server
RUN sudo chown -R shiny:shiny /etc/shiny-server/shiny-server.conf

RUN dos2unix /usr/bin/shiny-server.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

# copy the app to the image

COPY ./shiny-boardgames /srv/shiny-server/app
#COPY app.R /srv/shiny-server/
#COPY R /srv/shiny-server/R
#COPY data /srv/shiny-server/data

EXPOSE 3838
  
# run app
CMD ["/usr/bin/shiny-server.sh"]