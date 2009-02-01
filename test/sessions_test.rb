require File.dirname(__FILE__) + '/test_helper'
require 'action_controller/test_process'

class ApplicationController < ActionController::Base
end

class SessionsController < ApplicationController
  include Minimalist::Sessions
end

class SessionsControllerTest < ActionController::TestCase
  load_schema
  
  def setup
    @params = Hash.new
    @flash = Hash.new
  end
  
  def params; @params; end
  def flash; @flash; end
  
  test "should get new " do
    get :new
    assert_response :success
  end
  
  test "should create session" do
    params[:email] = 'test@testing.com'
    params[:password] = 'password'
    
  end
  
  test "should fail to create session" do
  end
  
  test "should destroy session" do
  end
end