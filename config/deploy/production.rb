server '52.193.2.110', user: 'you', roles: %w[app db web]

set :ssh_options, {
  keys: %w[/root/.ssh/aws_koechi.pem],
  forward_agent: true,
  auth_methods: %w[publickey]
}
