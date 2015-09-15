require 'net/http'
require 'json'

class API

	def request(payload)
		server = 'news.tut.by'
		method = '/exports/android_v2.php'
		port = '80'
		request = Net::HTTP::Post.new(method, initiheader = {'Content-Type' => 'application/json'})
  		request.body = payload
  		response = Net::HTTP.new(server, port).start {|http| http.request(request)}
  		return json_response = JSON.parse(response.body)
	end

	def finance_request
		server = 'finance.tut.by'
		method = '/export/info_for_pda.php'
		port = '80'
		request = Net::HTTP::Post.new(method)
		request.set_form_data(
			'auth_key' => 'hiLlo77mAul94oINk19ANile',
			'action' => 'get_best_rates',
			'params' => {"country" => "belarus","api-version" => 2,"locale" => "ru","ts" => "0","city_id" => 15800 }
		)
		response = Net::HTTP.new(server, port).start {|http| http.request(request)}
		return json_response = JSON.parse(response.body)
	end

end


