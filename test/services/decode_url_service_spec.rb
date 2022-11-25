require "test_helper"

class DecodeUrlServiceTest < ActiveSupport::TestCase
  setup do
    @link = links(:one)
  end

  test "SHOULD raise exception if encoded_url is not found" do
    service = DecodeUrlService.new(encoded_url: 'invalid_encoded_url')

    assert_raises(ActiveRecord::RecordNotFound) do
      service.call
    end
  end

  test "SHOULD return a url if encoded_url is existed in DB" do
    service = DecodeUrlService.new(encoded_url: @link.encoded_url)

    assert_nothing_raised do
      @url = service.call
    end

    assert_equal(@url, @link.url, "Decoded URL is not match with the input URL")
  end
end
