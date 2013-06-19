class  Rest::V1::ServiceAreasController < ApplicationController
  include ApplicationHelper

  respond_to :json

  def search
    result = ServiceArea::ServiceAvailable.find_by_zip_code(params[:zip_code])
    respond_with wrap_results(result,{:status => "success", :zip_code => params[:zip_code]})
  end
end