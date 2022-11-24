class ApplicationController < ActionController::API
  rescue_from StandardError do |exception|
    render_errors(title: 'Internal server error', detail: exception.message, status: 500)
  end

  rescue_from ArgumentError,
              ActionController::ParameterMissing do |exception|
    render_errors(title: 'Bad Request', detail: exception.message, status: 400)
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    detail = exception.record.errors.map { |error|
      {field: error.attribute, detail: error.full_message}
    }
    
    render_errors(title: 'Record invalid', detail: detail, status: 422)
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_errors(title: 'Not found', detail: exception.message, status: 404)
  end

  def render_errors(status:, title:, detail:)
    render json: {
      errors: [
        {
          title: title,
          detail: detail
        }
      ], status: status
    }
  end
end
