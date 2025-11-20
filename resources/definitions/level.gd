extends Resource
class_name Level
## Represents a parsed game level. This contains everything the game needs to
## runs.


## Just the JSON parsed to a Dictionary.
var raw_data: Dictionary
var player: Player
## Dictionary of game textures.
var textures: Dictionary[String, AtlasTexture]

## All tiles representing the map of the game.
var tilemap: Dictionary[String, Tile]


## Return texture if exists, else returns default texture.
func get_texture(id_texture: String) -> AtlasTexture:
	if textures.has(id_texture):
		return textures[id_texture]
	else:
		return textures["default"]


## Return monochrome version of texture if existe, else returns default 
## monochrome texture
func get_texture_monochrome(id_texture: String) -> AtlasTexture:
	id_texture = "monochrome_%s" % id_texture
	if textures.has(id_texture):
		return textures[id_texture]
	else:
		return textures["monochrome_default"]
