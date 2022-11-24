class DecodeUrlService

  def initialize(slug:)
    @slug = slug
  end

  def call
    Link.find_by!(slug: @slug)&.url
  end
end
