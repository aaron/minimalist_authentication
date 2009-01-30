require 'factory_girl'
module Factories
  Factory.define :user do |u|
    u.active true
    u.email 'test@testing.com'
    u.crypted_password 'password'
  end
end
