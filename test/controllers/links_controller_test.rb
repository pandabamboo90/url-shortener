require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @link = links(:one)
  end

  test "should response a valid encoded URL with message" do
    post encode_url, params: { url: 'https://valid_url.com' }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal(true, json_response.has_key?('message') && json_response.has_key?('encoded_url'))
    assert_equal(json_response['message'], 'URL encoded successfully')

    is_valid_url = URI.parse(json_response['encoded_url']).is_a?(URI::HTTP)
    assert_equal(true, is_valid_url)
  end

  test "should response a valid decoded URL with message" do
    post decode_url, params: { encoded_url: @link.encoded_url }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal(true, json_response.has_key?('message') && json_response.has_key?('url'))
    assert_equal(json_response['message'], 'URL decoded successfully')
    assert_equal(json_response['url'], @link.url)
  end

  test "should response 404 Not Found if trying to decoded a non-existed decoded url" do
    post decode_url, params: { encoded_url: 'non_existed_url' }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :not_found
    assert_equal(true, json_response.has_key?('errors') && json_response['errors'].is_a?(Array))
    error_hash = json_response['errors'].first
    assert_equal(true, error_hash.has_key?('title') && error_hash.has_key?('detail'))
  end
end
