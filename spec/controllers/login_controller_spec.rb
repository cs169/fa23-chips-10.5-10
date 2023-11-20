# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe LoginController do
  describe 'login controller method' do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = ModelHelper.mock_google_auth

      OmniAuth.config.mock_auth[:github] = {
        'uid'      => '123545',
        'provider' => 'github',
        'info'     => {
          'email' => 'example@gmail.com'
        }
      }
      @user = ModelHelper.init_github_user
      @uid = @user.id
    end

    it 'call google_oauth2' do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      get :google_oauth2
      expect(response).to redirect_to(root_url)
      expect(session[:current_user_id]).not_to be_nil
    end

    it 'call github' do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
      get :github
      expect(session[:current_user_id]).not_to be_nil
    end

    it 'call with logged in' do
      get :login, session: { current_user_id: @uid }
      expect(response).to redirect_to(user_profile_path)
    end
  end
end
