class EncodeUrlService
  def initialize(url:)
    @url = url
  end

  def call
    slug = ''

    link = Link.find_by(url: @url)

    if link.present?
      slug = link.slug
    else
      slug = SecureRandom.uuid[0..5]
      Link.create!(url: @url, slug: slug)
    end

    # Return the slug
    slug
  end
end
