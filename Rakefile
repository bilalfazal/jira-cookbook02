require 'kitchen'

desc 'Run Test Kitchen'
task :default do
  Kitchen.logger = Kitchen.default_file_logger
  @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.yml')
  config = Kitchen::Config.new(loader: @loader)
  config.instances.each do |instance|
    instance.test(:always)
  end
end
