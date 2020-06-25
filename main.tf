provider "auth0" {
  version = "~> 0.11"
}

resource "auth0_resource_server" "blog" {
  name       = "Blog Post API"
  identifier = "https://api.blog.com"

  scopes {
    value       = "write:post"
    description = "Write posts"
  }

  scopes {
    value       = "review:post"
    description = "Review posts"
  }
}

resource "auth0_role" "reviewer" {
  name        = "Reviewer"
  description = "Blog post reviewer"

  permissions {
    name                       = "review:post"
    resource_server_identifier = auth0_resource_server.blog.identifier
  }
}

resource "auth0_role" "writer" {
  name        = "Writer"
  description = "Blog post writer"

  permissions {
    name                       = "write:post"
    resource_server_identifier = auth0_resource_server.blog.identifier
  }
}

resource "auth0_user" "jane_doe" {
  connection_name = "Username-Password-Authentication"

  email = "jane.doe@blog.com"
  username = "jane"
  password = "I writez teh blogz!"

  roles = [auth0_role.writer.id]
}

resource "auth0_user" "john_doe" {
  connection_name = "Username-Password-Authentication"

  email = "john.doe@blog.com"
  username = "john"
  password = "I review dem blogz!"

  roles = [auth0_role.reviewer.id]
}