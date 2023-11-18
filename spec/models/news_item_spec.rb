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

describe NewsItem do
  describe 'testing state method' do
    before do
      @rep = Representative.create!({ name: 'Joseph R. Biden',
        ocdid: 'ocd-division/country:us', title: 'President of the United States' })

      @rep2 = Representative.create!({ name: 'Nancy',
        ocdid: 'ocd-division/country:us', title: 'other' })

      @new_item = described_class.create(
        representative: @rep,
        title:          'news story',
        description:    'news story description',
        link:           'google.com'
      )

      @new_item2 = described_class.create(
        representative: @rep2,
        title:          'news story',
        description:    'news story description',
        link:           'google.com'
      )
    end

    it 'call NewsItem find_for' do
      res = described_class.find_for(@rep.id)
      expect(res).to eq @new_item
    end
  end
end
