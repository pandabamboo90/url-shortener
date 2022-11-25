require "test_helper"

class EncodeUrlServiceTest < ActiveSupport::TestCase
  setup do
    @link = links(:one)
  end

  test "SHOULD return the encoded_url if the URL already encoded once" do
    service = EncodeUrlService.new(url: @link.url)
    @encoded_url = service.call

    assert_equal(@encoded_url, @link.encoded_url)
  end

  test "SHOULD raise exception if URL is invalid" do
    service = EncodeUrlService.new(url: 'invalid_url')

    assert_raises(ActiveRecord::RecordInvalid) do
      service.call
    end
  end

  test "SHOULD encode the URL and return a new encoded_url" do
    @url = 'http://valid_url'
    service = EncodeUrlService.new(url: @url)

    assert_nothing_raised do
      @encoded_url = service.call
    end

    assert_equal(Link.all.size, 3)
    assert_equal(Link.last.encoded_url, @encoded_url)
    assert_equal(Link.last.url, @url)
  end
end
