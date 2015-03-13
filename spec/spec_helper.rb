$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'regexy'
require 'coveralls'

Coveralls.wear!

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
