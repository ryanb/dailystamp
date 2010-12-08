# load app_config.yml
require 'yaml'
APP_CONFIG = YAML.load(File.read("#{Rails.root}/config/app_config.yml"))
