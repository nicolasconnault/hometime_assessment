class SchemaValidator
  SCHEMAS_DIR = Rails.root.join('app', 'schemas')

  attr_reader :payload, :endpoint, :schema

  def initialize(payload, endpoint)
    @payload = payload
    @endpoint = endpoint
  end

  def valid?
    Dir.glob("#{SCHEMAS_DIR}/#{@endpoint}/*.json").each do |schema_file|
      @schema = File.basename(schema_file, '.json')
      return true if JSON::Validator.validate(schema_file, payload)
    end
    false
  end
end
