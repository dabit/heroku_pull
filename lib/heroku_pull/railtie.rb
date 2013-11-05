module HerokuPull
  class Railtie < Rails::Railtie
    rake_tasks do
      require 'heroku_pull/tasks/heroku_pull.rake'
    end
  end
end
