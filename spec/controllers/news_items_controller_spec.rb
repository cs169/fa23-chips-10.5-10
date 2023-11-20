# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe NewsItemsController do
  describe 'news controller method' do
    before do
      @representative = Representative.create!({ name: 'Joseph R. Biden', created_at: '2023-11-18 23:14:54',
updated_at: '2023-11-18 23:14:54', ocdid: 'ocd-division/country:us', title: 'President of the United States' })
      @news_item = NewsItem.create!({ title: 'The big news', description: 'big news', link: 'google.com',
representative_id: @representative.id })
      @user = ModelHelper.init_github_user
      @uid = @user.id
    end

    it 'call index' do
      get :index, params: { representative_id: @representative.id }, session: { current_user_id: @uid }
      expect(assigns(:news_items)).to eq([@news_item])
      expect(assigns(:representative)).to eq(@representative)
      expect(response).to render_template :index
    end

    it 'call show' do
      get :show, params:  { representative_id: @representative.id, id: @news_item.id },
                 session: { current_user_id: @uid }
      expect(assigns(:representative)).to eq(@representative)
      expect(assigns(:news_item)).to eq(@news_item)

      expect(response).to render_template :show
    end
  end
end
