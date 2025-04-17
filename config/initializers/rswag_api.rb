Rswag::Api.configure do |c|
  # Where your OpenAPI JSON/YAML files live
  # This should match your project structure
  c.swagger_root = Rails.root.join('swagger').to_s
end
