require "test_helper"

class LinkTest < ActiveSupport::TestCase
  test "SHOULD NOT save Link without url, slug" do
    link = Link.new

    assert_not link.save
  end

  test "SHOULD NOT save Link if slug is existed" do
    existed_link = Link.first

    link = Link.new
    link.url = 'https://test_url.com'
    link.slug = existed_link.slug

    assert_not link.save
  end

  test "SHOULD NOT save Link if URL is invalid HTTP URL" do

    link = Link.new
    link.url = 'invalid_url'
    link.slug = 'unique'

    assert_not link.save
  end

  test "SHOULD NOT save Link if slug is too long (over 255 chars)" do
    link = Link.new
    link.url = 'https://test_url.com'
    link.slug = SecureRandom.alphanumeric(256)

    assert_not link.save
  end

  test "SHOULD save Link when url and slug are valid" do
    link = Link.new
    link.url = 'https://test_url.com'
    link.slug = 'unique'

    assert link.save
  end
end
