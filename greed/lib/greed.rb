lib = File.dirname(__FILE__)
require "#{lib}/greed/options"
Dir.glob(File.join(lib, 'greed', '**', '*.rb')).each{|f| require f}
