require 'logger'

logger = Logger.new(STDOUT)
logger.datetime_format = "%I:%M:%S%P "
logger.debug("Usuario 23643 logged")

=begin
require 'logger' 
logger = Logger.new(STDOUT) 
logger.datetime_format = "%h %d %Y - %I: %M: %S%P " 
logger.debug("Usuario 23643 logged") 
=end
