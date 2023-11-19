# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe User do
  describe 'methods' do
    before do
      @user1 = ModelHelper.init_github_user

      @user2 = ModelHelper.init_google_user
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
