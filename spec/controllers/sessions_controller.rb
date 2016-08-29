require 'rails_helper'
include Config
# include Github::Endpoints

RSpec.describe SessionsController do
  describe 'POST sessions#create' do
    context 'with a valid code' do
      before(:each) do
        # Stub call in services/github/auth#fetch_github_access_token
        WebMock.stub_request(:get, github_token_exchange_url)
          .with(query: { client_id: github_client_id, redirect_uri: '', client_secret: github_client_secret, code: 'valid_code' })
          .to_return(body: 'access_token=access_token&scope=user%2Cgist&token_type=bearer', status: 200)

        # Stub call in services/github/auth#fetch_github_hacker_profile
        WebMock.stub_request(:get, "#{github_api_base_url}/user")
          .with(headers: { 'Authorization' => 'token access_token' })
          .to_return(body: '{
                            "login": "octocat",
                            "id": 1,
                            "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                            "gravatar_id": "",
                            "url": "https://api.github.com/users/octocat",
                            "html_url": "https://github.com/octocat",
                            "followers_url": "https://api.github.com/users/octocat/followers",
                            "following_url": "https://api.github.com/users/octocat/following{/other_user}",
                            "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
                            "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
                            "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
                            "organizations_url": "https://api.github.com/users/octocat/orgs",
                            "repos_url": "https://api.github.com/users/octocat/repos",
                            "events_url": "https://api.github.com/users/octocat/events{/privacy}",
                            "received_events_url": "https://api.github.com/users/octocat/received_events",
                            "type": "User",
                            "site_admin": false,
                            "name": "monalisa octocat",
                            "company": "GitHub",
                            "blog": "https://github.com/blog",
                            "location": "San Francisco",
                            "email": "octocat@github.com",
                            "hireable": false,
                            "bio": "There once was...",
                            "public_repos": 2,
                            "public_gists": 1,
                            "followers": 20,
                            "following": 0,
                            "created_at": "2008-01-14T04:33:35Z",
                            "updated_at": "2008-01-14T04:33:35Z"
                          }', status: 200)
      end

      xit 'return a new created hacker' do
        post :create, code: 'valid_code'

        expect(Hacker.count).to eq 1
        expect(response.status).to eq 200

        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response).to have_key :token

        expect(json_response).to have_key :last_seen

        expect(json_response).to have_key :hacker
        expect(json_response[:hacker]).to have_key :id
        expect(json_response[:hacker]).to have_key :name
        expect(json_response[:hacker]).to have_key :email
        expect(json_response[:hacker]).to have_key :avatar_url
        expect(json_response[:hacker]).to have_key :display_name
      end

      xit 'returns already created hacker from the DB' do
        # post :create, code: 'valid_code'
        #
        # expect(Hacker.count).to eq 1
        # expect(response.status).to eq 200
        #
        # json_response = JSON.parse(response.body, symbolize_names: true)
        #
        # #FIXME: Fix this shit!
        # hacker_token  = json_response[:token]
        # expect(json_response[:token]).to eq hacker_token
      end
    end

    context 'with an invalid code' do
      before(:each) do
        WebMock.stub_request(:get, github_token_exchange_url)
          .with(query: { client_id: github_client_id, redirect_uri: '', client_secret: github_client_secret, code: 'invalid_code' })
          .to_return(body: '{"error": "Not Found"}', status: 404)
      end
      it 'return an authenication failed status and message' do
        post :create, code: 'invalid_code'

        expect(response.status).to eq 401

        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response[:error]).to eq 'Authenication Failed'
      end
    end
  end
end
