class CountriesController < ApplicationController
  def index
  	@result = Country.new
  	@result.all
  end
end
