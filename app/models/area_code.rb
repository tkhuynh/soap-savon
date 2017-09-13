class AreaCode
	attr_reader :city, :state, :zip_code, :area_code, :time_zone

	def initialize(area_code)
		url = 'http://www.webservicex.net/uszip.asmx?wsdl'.freeze
		client = Savon.client(wsdl: url,
                      log: true, # set true to switch on logging
                      log_level: :debug,
                      pretty_print_xml: true)
		response = client.call(:get_info_by_area_code, message: {"USAreaCode" => area_code})
		if response.success?
			{results: response.to_array(:get_info_by_area_code_response, :get_info_by_area_code_result, :new_data_set, :table)}
		else
			{error: "Request failed"}
		end
	end

end