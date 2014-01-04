require 'rails/railtie'

module HerokuPull
  class Railtie < Rails::Railtie
    rake_tasks do
      namespace :heroku do
        desc "Pull the Postgres database from Heroku into local server"
        task :pull do
          HerokuPull.app_name = ENV['APP']
          HerokuPull.capture
          HerokuPull.download
          HerokuPull.restore
        end
      end
    end
  end
end
