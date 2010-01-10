yaml = YAML::load(File.open(File.join(Rails.root, 'config', 'keys.yml')))
config = yaml[Rails.env]

CONSUMER_KEY = config['key']
CONSUMER_SECRET = config['secret']