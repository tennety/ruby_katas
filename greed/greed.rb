APP_ROOT = File.dirname(__FILE__)
Dir.glob(File.join(APP_ROOT, 'lib', '*.rb')).each{|f| require f}
