require 'docker'
require 'rspec'

images = Dir.glob('images/*').map do |dir|
          File.basename(dir) if File.directory?(dir)
         end.compact

namespace :build do
  desc 'Build all docker images'
  task :all => images

  images.each do |image|
    desc "Build #{image} docker image"
    task image.to_sym do
      Docker::Image.build_from_dir(File.join('images', image), t: image) do |v|
        if (log = JSON.parse(v)) && log.has_key?('stream')
          $stdout.puts log['stream']
        end
      end
    end
  end
end

namespace :test do
  targets = Dir.glob('spec/*').map do |dir|
              File.basename(dir) if File.directory?(dir)
            end.compact
  desc 'Run serverspec for all containers'
  task :all => targets

  targets.each do |target|
    desc "Run serverspec for #{target} containers"
    task target do
      container = Docker::Container.create(Image: target)
      container.start
      ENV['CONTAINER_ID'] = container.id
      specs = Dir.glob("spec/#{target}/*_spec.rb")
      RSpec::Core::Runner.run(specs)
      container.delete(force: true)
    end
  end
end

