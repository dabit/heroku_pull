require 'test_helper'

class HerokuPullTest < Test::Unit::TestCase
  def setup
    HerokuPull.app_name = nil
    stub(HerokuPull).puts
  end

  def test_app_name
    HerokuPull.app_name = "APP_NAME"
    assert_equal "APP_NAME", HerokuPull.app_name
  end

  def test_capture
    expected_cmd = "heroku pgbackups:capture --expire"
    mock(HerokuPull).system_with_app_name expected_cmd

    HerokuPull.capture
  end

  def test_download
    expected_cmd = "wget -O ./tmp/heroku_pull.sql `heroku pgbackups:url`"
    mock(HerokuPull).system_with_app_name expected_cmd

    HerokuPull.download
  end

  def test_restore
    stub(HerokuPull).database { "test_db" }
    expected_cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -d test_db ./tmp/heroku_pull.sql"
    mock(HerokuPull).system_with_app_name expected_cmd

    HerokuPull.restore
  end

  def test_system_with_app_name_set
    HerokuPull.app_name = "APP_NAME"
    expected_cmd = "COMMAND --app APP_NAME"
    mock(HerokuPull).system expected_cmd

    HerokuPull.system_with_app_name "COMMAND"
  end

  def test_system_with_app_name_not_set
    expected_cmd = "COMMAND"
    mock(HerokuPull).system expected_cmd

    HerokuPull.system_with_app_name expected_cmd
  end

  def test_filename
    assert_equal "./tmp/heroku_pull.sql", HerokuPull.filename
  end

  def test_database
    assert_equal "test_db", HerokuPull.database('test/config/database.yml')
  end
end


