require 'test_helper'

class HerokuPullTest < Test::Unit::TestCase
  def setup
    stub(HerokuPull).puts
  end

  def test_app_name
    HerokuPull.app_name = "APP_NAME"
    assert_equal "APP_NAME", HerokuPull.app_name
  end

  def test_capture
    expected_cmd = "heroku pgbackups:capture --expire"
    mock(HerokuPull).system expected_cmd

    HerokuPull.capture
  end

  def test_download
    expected_cmd = "wget -O ./tmp/heroku_pull.sql `heroku pgbackups:url`"
    mock(HerokuPull).system expected_cmd

    HerokuPull.download
  end

  def test_restore
    stub(HerokuPull).database { "test_db" }
    expected_cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -d test_db ./tmp/heroku_pull.sql"
    mock(HerokuPull).system expected_cmd

    HerokuPull.restore
  end

  def test_filename
    assert_equal "./tmp/heroku_pull.sql", HerokuPull.filename
  end

  def test_database
    assert_equal "test_db", HerokuPull.database('test/config/database.yml')
  end
end


