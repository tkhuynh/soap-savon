class AreaCodesController < ApplicationController
  def index
  	@info = AreaCode.new(params[:area_code]) if params[:area_code]
  end
end
