class LinksController < ApplicationController
  # POST /encode
  def encode
    slug = ::EncodeUrlService.new(url: params[:url])
                           .call

    render json: {
      message: "URL encoded successfully",
      shorten_url: slug
    }
  end

  # POST /decode
  def decode
    url = ::DecodeUrlService.new(slug: params[:slug])
                           .call

    render json: {
      message: "URL decoded successfully",
      url: url
    }
  end

  # DELETE /links/1
  def destroy
    @link.destroy
  end

  private

    # Only allow a list of trusted parameters through.
    def link_params
      params.permit(:url, :slug)
    end
end
