# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe ShowController do
  describe 'show controller method' do
    before do
      @representative = Representative.create!({ name: 'Joseph R. Biden', address: 'California',
      created_at: '2023-11-18 23:14:54',
updated_at: '2023-11-18 23:14:54', ocdid: 'ocd-division/country:us', title: 'President of the United States' })
      @fake_result = double
      @fake_service = double
      allow(@fake_service).to receive(:key=).and_return(Rails.application.credentials[:GOOGLE_API_KEY])
      allow(@fake_service).to receive(:representative_info_by_address).with(
        { address: 'California' }
      ).and_return(@fake_result)
      allow(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:new).and_return(@fake_service)
      allow(Representative).to receive(:civic_api_to_representative_param).with(
        @fake_result, 'Joseph R. Biden', 'President of the United States'
      ).and_return(@representative)
      @user = ModelHelper.init_github_user
      @uid = @user.id
    end

    it 'call show' do
      get :show, params:  { address: 'California', name: 'Joseph R. Biden', title: 'President of the United States' },
                 session: { current_user_id: @uid }
      expect(assigns(:representative)).to eq(@representative)
    end
  end
end
