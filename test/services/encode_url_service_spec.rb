require "test_helper"

class EncodeUrlServiceTest < ActiveSupport::TestCase
  setup do
    @link = links(:one)
  end

  test "SHOULD return the slug if the URL already encoded once" do
    service = EncodeUrlService.new(url: @link.url)
    @slug = service.call

    assert_equal(@slug, @link.slug)
  end

  test "SHOULD raise exception if URL is invalid" do
    service = EncodeUrlService.new(url: 'invalid_url')

    assert_raises(ActiveRecord::RecordInvalid) do
      service.call
    end
  end

  test "SHOULD encode the URL and return a new slug" do
    @url = 'http://valid_url'
    service = EncodeUrlService.new(url: @url)

    assert_nothing_raised do
      @slug = service.call
    end

    assert_equal(Link.all.size, 3)
    assert_equal(Link.last.slug, @slug)
    assert_equal(Link.last.url, @url)
  end
end
