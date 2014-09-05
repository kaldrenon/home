require 'rubygems'
require 'pry-remote'
require 'pry-rescue'
require 'pry-doc'

def time
  t = Time.now
  yield
  Time.now - t
end
