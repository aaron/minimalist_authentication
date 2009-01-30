require 'test/unit'
require 'rubygems'
require 'active_support'
require 'active_support/test_case'

ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))

require File.dirname(__FILE__) + '/factories'

class Test::Unit::TestCase
  include Factories
  
  class << self
    def load_schema
      ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
      ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
      load(File.dirname(__FILE__) + "/schema.rb")
    end
  end
  
  def teardown
    User.delete_all
  end
end

class User < ActiveRecord::Base
  include Minimalist::Authentication
end
