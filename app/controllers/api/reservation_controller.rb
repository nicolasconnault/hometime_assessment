class Api::ReservationController < ApplicationController
  def process_payload
    params.permit!
    schema_validator = SchemaValidator.new(params.to_json, 'reservations')

    if schema_validator.valid?
      mapper_klass = "Reservations::#{schema_validator.schema.camelize}Mapper".constantize 
      mapper = mapper_klass.new(params) 
      service = Reservations::SaveService.new(mapper)

      if service.execute
        render json: { success: 'Payload processed successfully' }, status: :ok
      else
        render json: { error: 'Failed to process payload' }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Invalid schema' }, status: :unprocessable_entity
    end
  rescue ActionDispatch::Http::Parameters::ParseError, JSON::ParserError
    render json: { message: 'Invalid JSON' }, status: :unprocessable_entity
  end
end
