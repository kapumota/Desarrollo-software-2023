require 'logger'

logger = Logger.new(STDOUT)
logger.info("Inicio de aplicacion")
begin
  0 / 0
rescue StandardError => e
  logger.error(e.message)
end
