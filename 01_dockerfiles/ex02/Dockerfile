From ruby
RUN apt update &&\
	apt install -y nodejs &&\
	gem install rails -v 5.2.3

ONBUILD COPY app /opt/
ONBUILD WORKDIR /opt/app
ONBUILD RUN bundle install && rake db:migrate && rake db:seed

# How to build
#docker build -t ft-rails:on-build .
