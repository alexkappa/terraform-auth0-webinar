provider "auth0" {
  version = "~> 0.11"
}

resource "auth0_resource_server" "my_server" {
  name       = "Blog Post API"
  identifier = "https://api.blog.com"

  scopes {
    value       = "create:post"
    description = "Create posts"
  }

  scopes {
    value       = "view:post"
    description = "View posts"
  }
}

resource "auth0_client" "my_client" {
  name = "Blog Post Bot 🚀"
  app_type = "non_interactive"
}

resource "auth0_client_grant" "my_client_grant" {
  client_id = auth0_client.my_client.client_id
  audience = auth0_resource_server.my_server.identifier
  scope = ["create:post"]
}