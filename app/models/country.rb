class Country
	attr_reader :client, :error, :countries, :info, :parser

	def initialize
		url = 'http://www.webservicex.net/country.asmx?WSDL'.freeze
		@client = Savon.client(wsdl: url)
		@parser = Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
	end

	def all
		response = self.client.call(:get_currencies)
		if response.success?
			response = response.body[:get_currencies_response][:get_currencies_result]
			# because result is a string
			response = @parser.parse(response)
			@countries = response[:new_data_set][:table]
		else
			@error = "Request failed"
		end
	end

	def more_info(country)
		response = self.client.call(:get_isd, message: {"CountryName" => country})
		if response.success?
			response = response.body[:get_isd_response][:get_isd_result]
			# because result is a string
			response = @parser.parse(response)
			@info = { isd: response[:new_data_set][:table] }
			response_two = self.client.call(:get_gm_tby_country, message: {"CountryName" => country})
			if response_two.success?
				response_two = response_two.body[:get_gm_tby_country_response][:get_gm_tby_country_result]
				# because result is a string
				response_two = @parser.parse(response_two)
				@info[:gmt] = response_two[:new_data_set][:table]
			end
		else
			@error = "Request failed"
		end
	end

end