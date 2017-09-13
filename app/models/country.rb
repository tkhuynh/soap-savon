class Country
	attr_reader :client, :error, :countries

	def initialize
		url = 'http://www.webservicex.net/country.asmx?WSDL'.freeze
		@client = Savon.client(wsdl: url)
	end

	def all
		response = self.client.call(:get_currencies)
		if response.success?
			response = response.body[:get_currencies_response][:get_currencies_result]
			# because result is a string
			parser = Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
			response = parser.parse(response)
			@countries = response[:new_data_set][:table]
		else
			@error = "Request failed"
		end
	end

end