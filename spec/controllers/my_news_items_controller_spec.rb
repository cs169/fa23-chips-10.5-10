# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe MyNewsItemsController do
  describe 'my news controller method' do
    before do
      @representative = Representative.create!({ name: 'Joseph R. Biden', created_at: '2023-11-18 23:14:54',
updated_at: '2023-11-18 23:14:54', ocdid: 'ocd-division/country:us', title: 'President of the United States' })
      @news_item = NewsItem.create!({ title: 'The big news', description: 'big news', link: 'google.com',
representative_id: @representative.id })
      @user = ModelHelper.init_github_user
      @uid = @user.id
      @news_item_hash = { title:             'The big news',
                          description:       'big news',
                          link:              'google.com',
                          representative_id: @representative.id }
      @news_item_hash_new = { title:             'The new one',
                              description:       'big news',
                              link:              'google.com',
                              representative_id: @representative.id }
      @news_item_hash_bad = { title:             'The big news',
                              description:       'big news',
                              link:              'google.com',
                              representative_id: '32453243423432' }

      @update_params_good = { representative_id: @representative.id, id: @news_item.id, news_item: @news_item_hash_new }
      @update_params_bad = { representative_id: @representative.id, id: @news_item.id, news_item: @news_item_hash_bad }
    end

    it 'call create w/ params' do
      post :create,
           params:  { representative_id: @representative.id, news_item: @news_item_hash },
           session: { current_user_id: @uid }
      expect(response).not_to render_template :new
    end

    it 'call create w/o params' do
      post :create,
           params:  { representative_id: @representative.id, news_item: @news_item_hash_bad },
           session: { current_user_id: @uid }
      @render = response
      expect(@render).to render_template :new
    end

    it 'call update w/ params' do
      put :update,
          params:  @update_params_good,
          session: { current_user_id: @uid }
      @news_item.reload
      expect(response).to redirect_to(representative_news_item_path(@representative, @news_item))
    end

    it 'call update w/o params' do
      put :update,
          # dsfsd
          params:  @update_params_bad,
          session: { current_user_id: @uid }
      expect(response).to render_template :edit
    end
  end
end
