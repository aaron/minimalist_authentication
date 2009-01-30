require 'test/unit'
require 'rubygems'
require 'active_support'
require 'active_support/test_case'

ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))

class Test::Unit::TestCase
  class << self
    def load_schema
      ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
      load(File.dirname(__FILE__) + "/schema.rb")
    end
  end
end