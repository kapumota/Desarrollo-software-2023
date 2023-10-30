require 'byebug'

usuarios = ["Aco", "Ire", ["Chalo"], "Claudio", "Tomo"]

usuarios.each do |usuario|
  byebug if usuario.class != String
end
