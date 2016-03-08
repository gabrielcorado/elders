## Development
* Running tests:
  1. Build the Docker image: `docker build -t elders .`
  2. Run the RSpec: `docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock elders bundle exec rspec`

### Extra
Interactive mode in the conteiner.

* `docker run --rm -it -v (PWD):/elders -v /var/run/docker.sock:/var/run/docker.sock elders /bin/bash`
