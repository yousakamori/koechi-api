server '52.193.2.110', user: 'you', roles: %w[app db web]

set :ssh_options, {
  # keys: %w[/root/.ssh/id_ed25519],
  forward_agent: true,
  auth_methods: %w[publickey]
}
