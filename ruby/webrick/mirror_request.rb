#!/usr/bin/ruby

require 'webrick'

class GetRoot < WEBrick::HTTPServlet::AbstractServlet

	def do_GET(request, response)
		status, content_type, body = do_stuff_with(request)

		response.status = status
		response['Content-Type'] = content_type
		response.body = body
	end

	def do_stuff_with(request)
		content= "<p>"+request.to_s+"</h1>"
		return 200, "text/html", content
	end

end

if $0 == __FILE__ then
	server = WEBrick::HTTPServer.new(:Port => 8000)
	server.mount "/", GetRoot
	trap "INT" do server.shutdown end
	server.start
end

