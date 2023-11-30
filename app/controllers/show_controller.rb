# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class ShowController < ApplicationController
  def show
    address = params[:address]
    name = params[:name]
    title = params[:title]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representative = Representative.civic_api_to_representative_param(result, name, title)

    render 'representatives/show'
  end
end
