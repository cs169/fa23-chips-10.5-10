# frozen_string_literal: true

class FinancesController < ApplicationController
  # GET /finances
  def index
    @cycle_options = [2010, 2012, 2014, 2016, 2018, 2020]
    @category_options = [
      ['Candidate Loan', 'candidate-loan'],
      ['Contribution Total', 'contribution-total'],
      ['Debts Owed', 'debts-owed'],
      ['Disbursements Total', 'disbursements-total'],
      ['End Cash', 'end-cash'],
      ['Individual Total', 'individual-total'],
      ['PAC Total', 'pac-total'],
      ['Receipts Total', 'receipts-total'],
      ['Refund Total', 'refund-total']
    ]
    render 'campaign_finances/finances'
  end
end
