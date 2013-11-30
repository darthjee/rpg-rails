settings = YAML.load(File.read(File.expand_path('../../config/mongo.yml', File.dirname(__FILE__))))["#{Rails.env}"]
MongoMapper.connection = Mongo::Connection.new(settings['host'], settings['port'])
MongoMapper.database = settings['database']

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect if forked
  end
end