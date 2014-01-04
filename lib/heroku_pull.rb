require "heroku_pull/version"
require "heroku_pull/railtie"
require "yaml"

module HerokuPull
  class << self
    attr_accessor :app_name

    def capture
      cmd = "heroku pgbackups:capture --expire"
      puts "Capture the database..."
      puts cmd
      system cmd_with_app_name(cmd)
    end

    def download
      cmd = "wget -O #{filename} `#{cmd_with_app_name("heroku pgbackups:url")}`"
      puts "Download backup file..."
      puts cmd
      system cmd
    end

    def restore
      cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -d #{database} #{filename}"
      puts "Restore local database..."
      puts cmd
      system cmd
    end

    def cmd_with_app_name(cmd)
      (HerokuPull.app_name ? "#{cmd} --app #{HerokuPull.app_name}" : cmd)
    end

    def filename
      "./tmp/heroku_pull.sql"
    end

    def database(config_path = './config/database.yml')
      ENV['RAILS_ENV'] ||= 'development'
      config   = YAML::load_file(config_path)
      database = config[ENV['RAILS_ENV']]['database']
    end
  end
end
