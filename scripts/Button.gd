extends Button


func _ready():
	$HTTPRequest.connect("request_completed",self,"_on_HTTPRequest_completed")






func _on_HTTPRequest_completed( result, response_code, headers, body ):
	if(response_code == 200):
		get_parent().get_node("TextEdit").text = body.get_string_from_utf8()
	else:
		print(response_code)


func _on_Button_pressed():
	$HTTPRequest.request("http://notunshokal.com/",PoolStringArray([]),false)
