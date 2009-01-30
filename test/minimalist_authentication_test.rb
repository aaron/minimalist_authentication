require File.dirname(__FILE__) + '/test_helper'

class MinimalistAuthenticationTest < ActiveSupport::TestCase
  load_schema
  
  class User < ActiveRecord::Base
  end
  
  test "should be ready to test" do
    assert_equal [], User.all
  end
end
