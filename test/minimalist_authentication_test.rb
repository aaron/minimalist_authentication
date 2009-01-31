require File.dirname(__FILE__) + '/test_helper'

class MinimalistAuthenticationTest < ActiveSupport::TestCase
  load_schema
  
  test "should not be able to set crypted_password through mass assignment" do
    user = Factory(:user)
    old_crypted_password = user.crypted_password
    user.update_attributes(:crypted_password => 'should not work')
    assert_equal(old_crypted_password, user.crypted_password)
  end
  
  test "should return active user" do
    user = Factory(:user)
    assert_equal([user], User.active)
  end
  
  test "should authenticate user" do
    user = Factory(:user)
    assert_equal(user, User.authenticate(user.email, 'password'))
  end
  
  test "should create salt and encrypted_password for new user" do
    user = User.new(:email => 'test@testing.com', :password => 'testing')
    assert(user.save)
    assert_not_nil(user.salt)
    assert_not_nil(user.crypted_password)
    assert(user.authenticated?('testing'))
  end
end
