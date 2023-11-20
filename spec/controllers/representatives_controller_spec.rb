# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe RepresentativesController do
  describe 'representative controller method' do
    before do
      @representative = Representative.create!({ name: 'Joseph R. Biden', created_at: '2023-11-18 23:14:54',
updated_at: '2023-11-18 23:14:54', ocdid: 'ocd-division/country:us', title: 'President of the United States' })
      @user = ModelHelper.init_github_user
      @uid = @user.id
    end

    it 'call index' do
      get :index, session: { current_user_id: @uid }
      expect(assigns(:representatives)).to eq(Representative.all)
      expect(response).to render_template :index
    end
  end
end
