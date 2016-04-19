require 'serverspec'
require 'docker'

set :backend, :docker
set :docker_url, ENV['DOCKER_HOST']
set :docker_container, ENV['CONTAINER_ID']
