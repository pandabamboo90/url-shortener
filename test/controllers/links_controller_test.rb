require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @link = links(:one)
  end

  test "should response encoded URL" do
    post encode_url, params: { url: 'https://valid_url.com' }, as: :json
    assert_response :success
  end

  test "should response decoded URL" do
    post decode_url, params: { slug: @link.slug }, as: :json
    assert_response :success
  end
end
