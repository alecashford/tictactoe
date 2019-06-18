# pull official base image
FROM ruby:2.0.0

# Copy project
COPY . .

# install dependencies
RUN bundle install

EXPOSE 8001/tcp

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "8001"]
