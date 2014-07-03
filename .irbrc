require 'rubygems'
require 'pry-remote'
require 'pry-debugger'
require 'pry-rescue'
require 'pry-doc'

Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'again', 'try-again'

def time
  t = Time.now
  yield
  Time.now - t
end
