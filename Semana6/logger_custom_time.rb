require 'logger'

logger = Logger.new(STDOUT)
logger.datetime_format = "%I:%M:%S%P "
logger.debug("Usuario 23643 logged")
