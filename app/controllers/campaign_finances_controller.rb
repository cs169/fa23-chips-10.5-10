# frozen_string_literal: true

class CampaignFinancesController < ApplicationController
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
    parsed_body = JSON.parse(response.body)
    @category_correct = index_helper(category)
    @top_people = parsed_body['results'].sort_by { |person| -person[@category_correct] }.first(20)
    render 'campaign_finances/index.html.erb'
  end

  def index_helper(category_name)
    category_mappings = {
      'candidate-loan'      => 'candidate_loans',
      'contribution-total'  => 'total_contributions',
      'debts-owed'          => 'debts_owed',
      'disbursements-total' => 'total_disbursements',
      'end-cash'            => 'end_cash',
      'individual-total'    => 'total_from_individuals',
      'pac-total'           => 'total_from_pacs',
      'receipts-total'      => 'total_receipts',
      'refund-total'        => 'total_refunds'
    }
    category_mappings[category_name]
  end
end
