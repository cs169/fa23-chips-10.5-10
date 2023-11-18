# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

if RUBY_VERSION >= '2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts 'Monkeypatch for ActionController::TestResponse no longer needed'
  end
end

describe User do
  describe 'methods' do
    before do
      @user1 = described_class.create!({
                                         provider:   'github',
                                         uid:        '12345',
                                         email:      'github_test@example.com',
                                         first_name: 'Github',
                                         last_name:  'Test Developer',
                                         created_at: '2023-11-18 22:13:11',
                                         updated_at: '2023-11-18 22:13:11'
                                       })

      @user2 = described_class.create!({
                                         provider:   'google_oauth2',
                                         uid:        '100000000000000000000',
                                         email:      'google_test@example.com',
                                         first_name: 'Google',
                                         last_name:  'Test Developer',
                                         created_at: '2023-11-18 22:12:50',
                                         updated_at: '2023-11-18 22:12:50'
                                       })
    end

    it 'call name' do
      res = @user1.name
      expect(res).to eq 'Github Test Developer'
    end

    it 'call auth_provider' do
      res = @user1.auth_provider
      expect(res).to eq 'Github'
    end

    it 'call User find_google_user' do
      res = described_class.find_google_user('100000000000000000000')
      expect(res).to eq @user2
    end

    it 'call User find_github_user' do
      res = described_class.find_github_user('12345')
      expect(res).to eq @user1
    end
  end
end
