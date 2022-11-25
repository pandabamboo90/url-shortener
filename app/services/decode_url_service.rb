class DecodeUrlService

  def initialize(encoded_url:)
    @encoded_url = encoded_url
  end

  def call
    Link.find_by!(encoded_url: @encoded_url)&.url
  end
end
