# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe MyEventsController do
  describe 'my events controller method' do
    before do
      arr = ModelHelper.init_slo
      @cali = arr[0]
      @slo = arr[1]

      arr2 = ModelHelper.init_county('AnotherState', 'DF', 8, 'Another County', 34)
      @diff_state = arr2[0]
      @diff_county = arr2[1]

      @event_slo = ModelHelper.create_event(@slo, 'Pride Parade')

      @event_diff_county = ModelHelper.create_event(@diff_county, 'Other Parade')
      @user = ModelHelper.init_github_user
      @uid = @user.id

      @event_hash = { name:        'New Event Name!',
                      description: 'Annual pride parade',
                      county_id:   @slo.id,
                      start_time:  '2023-12-16 21:17:47',
                      end_time:    '2023-12-16 22:17:48' }
    end

    it 'call create w/o params' do
      post :create, params: { event: { name: 'New Event Name!' } }, session: { current_user_id: @uid }
      expect(response).to render_template :new
    end

    it 'call create w/ params' do
      post :create, params: { event: @event_hash }, session: { current_user_id: @uid }
      expect(response).to redirect_to(events_path)
    end
  end
end
