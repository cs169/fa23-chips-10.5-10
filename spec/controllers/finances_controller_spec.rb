# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe FinancesController do
  describe 'finances controller method' do
    before do
      @user = ModelHelper.init_github_user
      @uid = @user.id
    end

    it 'call profile' do
      get :index, session: { current_user_id: @uid }
      expect(assigns(:cycle_options)).to eq([2010, 2012, 2014, 2016, 2018, 2020])
      expect(response).to render_template 'campaign_finances/finances'
    end
  end
end
