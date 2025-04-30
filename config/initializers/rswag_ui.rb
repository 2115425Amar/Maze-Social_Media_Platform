Rswag::Ui.configure do |c|
  c.openapi_endpoint '/api-docs/v1/posts.yaml',         'Posts API'
  c.openapi_endpoint '/api-docs/v1/users.yaml',         'Users API'
  c.openapi_endpoint '/api-docs/v1/comments.yaml',      'Comments API'
  # c.openapi_endpoint '/api-docs/v1/registrations.yaml', 'User Registration'
  # c.openapi_endpoint '/api-docs/v1/swagger.json', 'Swagger UI'
  c.swagger_endpoint '/api-docs/v1/likes.yaml', 'Likes API V1'
  c.openapi_endpoint '/api-docs/v1/reports.yaml', 'Reports API V1'
  c.openapi_endpoint '/api-docs/v1/users/registrations.yaml', 'Registrations API V1'
  c.openapi_endpoint '/api-docs/v1/users/login.yaml', 'Login API V1'
end