require 'rubygems'
require 'interactive_editor'

def time
  t = Time.now
  yield
  Time.now - t
end
