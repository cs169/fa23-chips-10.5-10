# frozen_string_literal: true

class CampaignFinancesController < ApplicationController
  # GET /campaign_finances?cycle=2010&category=candidate-loan
  def index
    # TODO: make the params required AND ensure params are well-defined
    category = params[:category]
    cycle = params[:cycle]
    conn = Faraday.new(
      url:     "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json",
      headers: { 'Content-Type' => 'application/json',
                 'X-API-Key'    => Rails.application.credentials[:PROPUBLICA_API_KEY] }
    )
    response = conn.get
    @body = response.body
  end
end
