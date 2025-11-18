extends Operation
class_name LevelParser

var colored_texture: CompressedTexture2D = preload("res://images/tileset_colored.png")
var monochrome_texture: CompressedTexture2D = preload("res://images/tileset_monochrome.png")
var json_loader: JSONLoader = JSONLoader.new()
var data: Level = null


func load_from_path(path: String) -> void:
	data = Level.new()

	# Load raw_data
	json_loader.load_from_path(path)
	if json_loader.error == OK:
		data.raw_data = json_loader.data
	else:
		error = json_loader.error
		error_message = json_loader.error_message
		return
	
	# Load textures
	data.textures = parser_textures(data.raw_data)


	# Checks if any error occur
	if error != OK:
		return

	# Get no errors
	error = OK
	error_message = ""


func parser_textures(raw_data: Dictionary) -> Dictionary[String, AtlasTexture]:
	var textures: Dictionary[String, AtlasTexture] = {}

	for key in raw_data.textures:
		var texture_data = raw_data.textures[key]

		if not (texture_data.has("x") or texture_data.has("y")):
			error = ERR_INVALID_DATA
			error_message = "Texture %s without position" % key

		var texture: AtlasTexture = AtlasTexture.new()
		texture.atlas = colored_texture
		texture.region = Rect2(
			texture_data["x"] * Utils.tile_size.x,
			texture_data["y"] * Utils.tile_size.y,
			Utils.tile_size.x,
			Utils.tile_size.y
		)

		textures[key] = texture

	return textures
