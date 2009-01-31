require 'factory_girl'
module Factories
  Factory.define :user do |u|
    u.active true
    u.email 'test@testing.com'
    u.crypted_password '8ecb4ab58c77d2176a0b932c1da306cf7bdfd062' # password
    u.salt 'salt'
  end
end
