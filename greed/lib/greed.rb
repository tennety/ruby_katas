lib = File.dirname(__FILE__)
Dir.glob(File.join(lib, 'greed', '*.rb')).each{|f| require f}
