require File.dirname(__FILE__) + '/test_helper'

class MinimalistAuthenticationTest < ActiveSupport::TestCase
  load_schema
  
  test "should return active user" do
    user = Factory(:user)
    assert_equal([user], User.active)
  end
  
  test "should authenticate user" do
    user = Factory(:user)
    assert_equal(user, User.authenticate(user.email, user.crypted_password))
  end
end
