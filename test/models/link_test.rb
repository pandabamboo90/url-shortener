require "test_helper"

class LinkTest < ActiveSupport::TestCase
  test "SHOULD NOT save Link without url, encoded_url" do
    link = Link.new

    assert_not link.save
  end

  test "SHOULD NOT save Link if encoded_url is existed" do
    existed_link = Link.first

    link = Link.new
    link.url = 'https://test_url.com'
    link.encoded_url = existed_link.encoded_url

    assert_not link.save
  end

  test "SHOULD NOT save Link if URL is invalid HTTP URL" do
    link = Link.new
    link.url = 'invalid_url'
    link.encoded_url = 'unique'

    assert_not link.save
  end

  test "SHOULD NOT save Link if encoded_url is too long (over 255 chars)" do
    link = Link.new
    link.url = 'https://test_url.com'
    link.encoded_url = SecureRandom.alphanumeric(256)

    assert_not link.save
  end

  test "SHOULD save Link when url and encoded_url are valid" do
    link = Link.new
    link.url = 'https://test_url.com'
    link.encoded_url = 'unique'

    assert link.save
  end
end
