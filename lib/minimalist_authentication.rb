# MinimalistAuthentication
require 'minimalist/authentication'
require 'app/controllers/application_controller'
require 'app/controllers/sessions_controller'

%w{ controllers }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end