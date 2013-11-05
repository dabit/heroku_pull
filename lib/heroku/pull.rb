require "heroku/pull/version"

module Heroku
  module Pull
    class << self
      def capture
        cmd = "heroku pgbackups:capture --expire"
        puts "Capture the database..."
        puts cmd
        system cmd
      end

      def download
        cmd = "wget -O #{filename} `heroku pgbackups:url`"
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

      def filename
        "./tmp/heroku-pull.sql"
      end

      def database
        ENV['RAILS_ENV'] ||= 'development'
        config   = YAML::load_file('./config/database.yml')
        database = config[ENV['RAILS_ENV']]['database']
      end
    end
  end
end
