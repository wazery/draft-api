[![Docker Repository on Quay](https://quay.io/repository/wazery/draft-api/status?token=ccad28c7-a2df-4e5e-9ebd-fa2f1eeb5059 "Docker Repository on Quay")](https://quay.io/repository/wazery/draft-api)

![Draft Logo](https://dl.dropboxusercontent.com/u/71605080/logo.png)

# Draft Agnostic Rails API
The agnostic Rails API that powers the Draft Chrome extension, Angular web and mobile applications.

# Local Installation
1. Clone the repo
2. Start MongoDB daemon
3. Start Redis server
4. Create your `config/secrets.yml` config file
5. Start the Rails server via `rails server or rails s`

# Secrets.yml
You Should create a file under `config` directory for your application secrets. It should conform to the following style:

```yml
development: &development
  secret_key_base: token

production:
  secret_key_base: token

test:
  <<: *development

github_client_id: token
github_client_secret: token

```
