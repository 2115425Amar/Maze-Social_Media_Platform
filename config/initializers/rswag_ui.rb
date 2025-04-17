# config/initializers/rswag_ui.rb
Rswag::Ui.configure do |c|
  # Tell rswag‑ui where rswag‑api is serving your spec
  # (Use “openapi_endpoint” in place of the older “swagger_endpoint”)
  c.openapi_endpoint '/api-docs/v1/swagger.yaml', 'API V1 Docs'
end
