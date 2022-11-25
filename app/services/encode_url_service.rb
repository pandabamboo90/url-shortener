class EncodeUrlService
  def initialize(url:)
    @url = url
  end

  def call
    link = Link.find_by(url: @url)

    if link.present?
      encoded_url = link.encoded_url
    else
      encoded_url = SecureRandom.uuid[0..5]
      Link.create!(url: @url, encoded_url: encoded_url)
    end

    # Return the encoded_url
    encoded_url
  end
end
