require 'logger'

logger = Logger.new(STDOUT)
logger.info("Inicio de aplicacion")
usuarios = ["Chalo", "Claudio", "Tomo", "Aco", "Irene"]
if usuarios.length > 3
  logger.warn("Advertencia, hay #{usuarios.length} usuarios")
end
usuarios.each do |usuario|
  logger.debug("Usuario: #{usuario}")
end
logger.info("Final de aplicacion")

=begin
require 'logger'

#logger = Logger.new(STDOUT)
logger = Logger.new(STDOUT, level: Logger::ERROR)
logger.level = Logger::INFO
logger.info("Inicio de aplicacion")
usuarios = ["Chalo", "Claudio", "Tomo", "Aco", "Irene"]
if usuarios.length > 3
  logger.warn("Advertencia, hay #{usuarios.length} usuarios")
end
usuarios.each do |usuario|
  logger.debug("Usuario: #{usuario}")
end
logger.info("Final de aplicacion")
=end
