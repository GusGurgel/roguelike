extends Node2D
class_name Game
## Represents a parsed playable game. This contains everything the game needs to
## run.

var layer_scene = preload("res://scenes/layer.tscn")
var tile_scene = preload("res://scenes/tile.tscn")

## Just file/string JSON parsed to a Dictionary.
var raw_data: Dictionary
var player: Player
## Dictionary of game textures.
var textures: Dictionary[String, AtlasTexture]
## Dictionary of presets of tiles
var tiles_presets: Dictionary[String, Tile]


## All layers of the game
var layers: Dictionary[String, Layer]
var current_layer: String:
	set(new_current_layer):
		var old_current_layer = current_layer
		if layers.has(new_current_layer):
			current_layer = new_current_layer
		else:
			if len(layers.keys()) > 0:
				current_layer = layers.keys()[0]
			else:
				layers["default"] = layer_scene.instantiate()
				current_layer = "default"
		if old_current_layer and layers[old_current_layer].get_parent() == self:
			remove_child(layers[old_current_layer])
		add_child(layers[current_layer])
	

func _ready() -> void:
	# Add player and set game reference to the player
	player.game = self
	add_child(player)


## Return tile from current layer
func get_tile(pos: Vector2i) -> Tile:
	return layers[current_layer].get_tile(pos)


## Erase tile from the current layer. Return true if a tile was removed
func erase_tile(pos: Vector2i) -> bool:
	return layers[current_layer].erase_tile(pos)


## Return texture if exists, else returns "default" texture.
func get_texture(id_texture: String) -> AtlasTexture:
	if textures.has(id_texture):
		return textures[id_texture]
	else:
		return textures["default"]


## Return monochrome version of texture if existe, else returns "default 
## monochrome" texture
func get_texture_monochrome(id_texture: String) -> AtlasTexture:
	id_texture = "monochrome_%s" % id_texture
	if textures.has(id_texture):
		return textures[id_texture]
	else:
		return textures["monochrome_default"]

## Return tile preset, or null if not exists
func get_tile_preset(id_tile_preset) -> Tile:
	return tiles_presets.get(id_tile_preset)

	
## Returns a JSON string representing the current Game
## TODO
func stringify() -> String:
	return ""
