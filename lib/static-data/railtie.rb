require 'static-data'
require 'rails'
module YourGem
  class Railtie < Rails::Railtie
    rake_tasks do
      require 'rake'
      load 'static-data/tasks.rake'
    end
  end
end