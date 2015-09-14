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

end


