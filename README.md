# Elders [![Build Status](https://travis-ci.org/gabrielcorado/elders.svg?branch=master)](https://travis-ci.org/gabrielcorado/elders)
Enable you to run your command line tasks in containers.

## Usage

### Task

```ruby
# Create a new task
# Params are `name`, `image` and `command`
task = Elder::Task.new 'sample', 'ruby', 'ruby'

# Start the task passing params to the command and ENV variables
task.start '-v'

# Wait until the task is finished
sleep 1

# Return it results
task.logs

# Remove the docker container used in this operation
task.clean
```

## TODO
* Enable more options to the task (like `links`, `volumes`, `network`).
* Create a method `:wait` for the `Elders::Task`, this will block
  the main thread until the task is completed.
* Doc the `Elders::Stack` usage.

## Development
* Running tests:
  1. Build the Docker image: `docker build -t elders .`
  2. Run the RSpec: `docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock elders bundle exec rspec`

### Extra
Interactive mode in the conteiner.

* `docker run --rm -it -v (PWD):/elders -v /var/run/docker.sock:/var/run/docker.sock elders /bin/bash`
