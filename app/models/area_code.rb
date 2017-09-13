class AreaCode
	attr_reader :cities, :error

	def initialize(area_code)
		url = 'http://www.webservicex.net/uszip.asmx?wsdl'.freeze
		client = Savon.client(wsdl: url)
		response = client.call(:get_info_by_area_code, message: {"USAreaCode" => area_code})
		if response.success?
			@cities = response.to_array(:get_info_by_area_code_response, :get_info_by_area_code_result, :new_data_set, :table)
		else
			@error = "Request failed"
		end
	end

end