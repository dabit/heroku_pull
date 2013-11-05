require 'heroku_pull'

namespace :heroku do
  task :pull do
    HerokuPull.capture
    HerokuPull.download
    HerokuPull.restore
  end
end
