extends Node

var http_request : HTTPRequest

func _ready():
	# Create the HTTPRequest node
	http_request = HTTPRequest.new()
	add_child(http_request)
	
	# Connect the request_completed signal to a method
	http_request.connect("request_completed", self, "_on_request_completed")
	
	# Make the GET request to a URL (replace with your API URL)
	var url = "https://gist.githubusercontent.com/NeonGamerBot-QK/ea27718800705b39e2bdc42a77de8a59/raw/4c86fe5c18fab7507abf686dbcab0ff36bdeb12b/example.json"
	var error = http_request.request(url)

	if error != OK:
		print("Request failed with error code: ", error)

# Signal handler for the response
func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		# The request was successful
		print("Response: ", body.get_string_from_utf8())
	else:
		# Something went wrong
		print("Error: HTTP Status Code ", response_code)
