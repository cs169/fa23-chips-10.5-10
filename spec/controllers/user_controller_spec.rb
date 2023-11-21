# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe UserController do
  describe 'user controller method' do
    before do
      @user = ModelHelper.init_github_user
      @uid = @user.id
    end

    it 'call profile' do
      get :profile, session: { current_user_id: @uid }
      expect(assigns(:user)).to eq(@user)
      expect(response).to render_template :profile
    end
  end
end
