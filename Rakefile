require 'rake'

require ::File.expand_path('../config/environment', __FILE__)

# Include all of ActiveSupport's core class extensions, e.g., String#camelize
require 'active_support/core_ext'

desc 'Start IRB with application environment loaded'
task "console" do
  exec "irb -r./config/environment"
end


# In a production environment like Heroku, RSpec might not
# be available.  To handle this, rescue the LoadError.
# https://devcenter.heroku.com/articles/getting-started-with-ruby-o#runtime-dependencies-on-development-test-gems
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

task :default  => :spec
