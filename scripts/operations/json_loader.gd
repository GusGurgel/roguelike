extends Operation
class_name JSONLoader


var data: Dictionary


## Load a "strinfied" JSON. Only accepts JSON Dictionaries.
func load_from_string(json_string: String) -> void:
	var json = JSON.new()
	var json_error = json.parse(json_string)
	if json_error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			data = data_received as Dictionary
			error_message = ""
			error = OK
		else:
			error_message = "JSON is not valid."
			error = ERR_INVALID_DATA
	else:
		error_message = "JSON is not valid."
		error = ERR_PARSE_ERROR


func load_from_path(path: String) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		file.close()
		load_from_string(json_string)
	else:
		error = ERR_DOES_NOT_EXIST
		error_message = "File '%s' does not exists." % path