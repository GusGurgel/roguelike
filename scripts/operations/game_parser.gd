extends Operation
class_name GameParser
## Parsers a JSON into a playable game.

var data: Game = preload("res://scenes/game/game.tscn").instantiate()

var player_scene = preload("res://scenes/entities/player.tscn")
var layer_scene = preload("res://scenes/layer.tscn")

# Entities scenes
var entity_scene = preload("res://scenes/entities/entity.tscn")
var enemy_scene = preload("res://scenes/entities/enemy.tscn")

# Items scenes
var item_scene = preload("res://scenes/itens/item.tscn")
var item_healing_potion_scene = preload("res://scenes/itens/healing_potion.tscn")
var item_melee_weapon_scene = preload("res://scenes/itens/melee_weapon.tscn")


var colored_texture: CompressedTexture2D = preload("res://images/tileset_colored.png")
var monochrome_texture: CompressedTexture2D = preload("res://images/tileset_monochrome.png")
var json_loader: JSONLoader = JSONLoader.new()

func _init():
	Globals.game = data


func load_from_path(path: String, game_ui: GameUI) -> void:
	# Load raw_data.
	json_loader.load_from_path(path)
	if json_loader.has_erros():
		error_messages.append_array(json_loader.error_messages)
		return
	
	load_from_dict(json_loader.data, game_ui)


func load_from_dict(dict: Dictionary, game_ui: GameUI) -> void:
	data.raw_data = dict

	data.game_ui = game_ui
	
	# Load textures.
	data.textures = TextureList.new()
	if not data.raw_data.has("textures"):
		Utils.print_warning("Game without a texture list.")
	else:
		data.textures.load(data.raw_data["textures"])

	# Load tiles_presets
	data.tiles_presets = TilePresetList.new()
	if not data.raw_data.has("tiles_presets"):
		Utils.print_warning("Game without a tile preset list.")
	else:
		data.tiles_presets.load(data.raw_data["tiles_presets"])

	# Load player.
	data.player = player_scene.instantiate()
	if not data.raw_data.has("player"):
		Utils.print_warning("Game without a player.")
	else:
		data.player.load(data.raw_data["player"])

	# Load layers.
	data.layers = parse_layers(data.raw_data)


	Utils.copy_from_dict_if_exists(
		data,
		data.raw_data,
		["current_layer", "turn"],
		["current_layer", "turn"]
	)


func parse_layers(raw_data: Dictionary) -> Dictionary[String, Layer]:
	var layers: Dictionary[String, Layer] = {}

	if not raw_data.has("layers"):
		warning_messages.push_back("Game without layers.")
		return layers

	for layer_key in raw_data["layers"]:
		layers[layer_key] = parse_layer(layer_key, raw_data["layers"])

	return layers


func parse_layer(layer_key: String, layers_data: Dictionary) -> Layer:
	var layer: Layer = layer_scene.instantiate()
	var layer_data = layers_data[layer_key]
	layer.load(layer_data)

	return layer


func parse_tile_grid_position(tile_key: String) -> Vector2i:
	if tile_key == "":
		return Vector2i.ZERO

	var regex_result: RegExMatch = Globals.vector2i_string_regex.search(tile_key)
	var grid_position: Vector2i

	if not regex_result:
		warning_messages.push_back("Invalid tilemap tile_key '%s'" % tile_key)
		return grid_position

	grid_position.x = regex_result.strings[1].to_int()
	grid_position.y = regex_result.strings[2].to_int()
	return grid_position
