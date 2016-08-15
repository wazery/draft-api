[![Build Status](http://104.131.207.101/api/badge/github.com/wazery/api/status.svg?branch=master)](http://104.131.207.101/github.com/wazery/api)

![Draft Logo](https://raw.githubusercontent.com/wazery/api/dev/public/images/logo.png?token=AActgZWd9j8UwdwUXUndWIWbbMVv8f2Bks5WEqt1wA%3D%3D)

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
