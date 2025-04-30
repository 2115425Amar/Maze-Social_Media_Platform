Rswag::Api.configure do |c|
  # serve everything under <rails_root>/swagger
  c.openapi_root = Rails.root.join('swagger').to_s
end
