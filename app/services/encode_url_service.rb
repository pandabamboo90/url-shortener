class EncodeUrlService
  def initialize(url:)
    @url = url
  end

  def call
    link = Link.find_by(url: @url)

    if link.blank?
      encoded_domain = [SecureRandom.uuid[0..5], SecureRandom.uuid[0..2]].join('.')
      url_scheme = @url.split('//').first
      link = Link.create!(url: @url, encoded_url: [url_scheme, encoded_domain].join('//'))
    end

    # Return the encoded_url
    link.encoded_url
  end
end
