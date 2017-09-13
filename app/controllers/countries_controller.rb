class CountriesController < ApplicationController
  def index
  	@result = Country.new
  	@result.all
  end

  def country
  	@result = Country.new
  	@result.more_info(params[:country])
  end
end
