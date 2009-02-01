require File.dirname(__FILE__) + '/test_helper'

class AuthorizationTest < ActiveSupport::TestCase
  def AuthorizationTest.helper_method(*args); end
  include Minimalist::Authorization
  load_schema
  
  def setup
    @session = Hash.new
  end
  
  def session
    @session
  end
  
  test "should return guest for current_user" do
    assert_equal('guest', current_user.email)
  end
  
  test "should return logged_in user for current_user" do
    user = Factory(:user)
    session[:user_id] = user.id
    assert_equal(user, current_user)
  end
  
end