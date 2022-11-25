class LinksController < ApplicationController
  # POST /encode
  def encode
    encoded_url = ::EncodeUrlService.new(url: params[:url])
                           .call

    render json: {
      message: "URL encoded successfully",
      encoded_url: encoded_url
    }
  end

  # POST /decode
  def decode
    url = ::DecodeUrlService.new(encoded_url: params[:encoded_url])
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
      params.permit(:url, :encoded_url)
    end
end
