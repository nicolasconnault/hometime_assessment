class Api::ReservationController < ApplicationController
  def process_payload
    payload = JSON.parse(request.body.read)
    schema_validator = SchemaValidator.new(payload, 'reservations')

    if schema_validator.valid?
      service_klass = "Reservations::#{schema_validator.schema.camelize}Service".constantize
      service = service_klass.new(payload)

      if service.process_payload
        render json: { success: 'Payload processed successfully' }, status: :ok
      else
        render json: { error: 'Failed to process payload' }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Invalid schema' }, status: :unprocessable_entity
    end
  rescue JSON::ParserError
    render json: { message: 'Invalid JSON' }, status: :unprocessable_entity
  end
end
