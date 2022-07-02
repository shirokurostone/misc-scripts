require "minitest/autorun"
require "./time.rb"

class TestTimeWorkflow < Minitest::Test
  def setup
    @mock = Minitest::Mock.new
    @wf = TimeWorkflow.new(@mock)
  end

  def test_now
    @mock.expect(:now, Time.local(2022, 7, 1, 2, 3, 4))
    actual = @wf.run("")
    expected_items = [
      {
        title: "Copy unixtime : '1656608584'",
        subtitle: "2022-07-01 02:03:04 +0900",
        arg: ["1656608584"]
      },
      {
        title: "Copy localtime : '2022-07-01 02:03:04 +0900'",
        subtitle: "2022-07-01 02:03:04 +0900",
        arg: ["2022-07-01 02:03:04 +0900"]
      },
    ]
    assert_equal(expected_items, actual[:items])
  end

  def test_convert_to_localtime
    @mock.expect(:at, Time.local(2022, 7, 1, 2, 3, 4), [1656608584])
    actual = @wf.run("1656608584")
    expected_items = [{
      title: "Convert to localtime : '2022-07-01 02:03:04 +0900'",
      subtitle: "1656608584",
      arg: ["2022-07-01 02:03:04 +0900"]
    }]
    assert_equal(expected_items, actual[:items])
  end

  def test_convert_to_unixtime
    @mock.expect(:parse, Time.local(2022, 7, 1, 2, 3, 4), ["2022-07-01 02:03:04 +0900"])
    actual = @wf.run("2022-07-01 02:03:04 +0900")
    expected_items = [{
      title: "Convert to unixtime : '1656608584'",
      subtitle: "2022-07-01 02:03:04 +0900",
      arg: ["1656608584"]
    }]
    assert_equal(expected_items, actual[:items])
  end
end