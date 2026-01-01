extends SerializableNode2D
class_name Game
## Represents a parsed playable game. This contains everything the game needs to
## run.

var field_of_view: FieldOfView = FieldOfView.new()

var tile_scene = preload("res://scenes/tile.tscn")

## Just file/string JSON parsed to a Dictionary.
var raw_data: Dictionary
var player: Player
## Dictionary of game textures.
var textures: TextureList = TextureList.new()
## Dictionary of presets of tiles
var tiles_presets: TilePresetList = TilePresetList.new()

var turn: int = 0:
	set(new_turn):
		# Alert layer entities thats the turn has change
		# var current_layer_entities: Dictionary[String, Item] = get_current_layer().entities
		# for entity_key in current_layer_entities:
		# 	var entity: Item = current_layer_entities[entity_key]
		# 	if is_instance_valid(entity):
		# 		entity._on_turn_updated(turn, new_turn)
		# 	else:
		# 		# Remove invalid entity
		# 		current_layer_entities.erase(entity_key)
		game_ui.turn_value_label.text = str(new_turn)
		turn = new_turn


var game_ui: GameUI

var layers: LayerList = LayerList.new()
var layer: Layer:
	get():
		return layers.get_current_layer()
	set(new_layer):
		pass
	
@onready var tile_painter: TilePainter = TilePainter.new()


func _ready() -> void:
	field_of_view.name = "FieldOfView"
	tile_painter.name = "TilePainter"
	layers.name = "Layers"
	add_child(field_of_view)
	add_child(tile_painter)

	## Set reference to game on player and field_of_view.
	player.game = self
	field_of_view.game = self

	## Add player
	add_child(player)
	game_ui.debug_ui.player = player
	player.tile_grid_position_change.connect(game_ui.debug_ui._on_player_change_grid_position)
	player.grid_position = player.grid_position

	add_child(layers)


## Set a tile by a preset. [br]
## If preset == "", nothing happens.
func set_tile_by_preset(
	preset: String,
	pos: Vector2i,
	set_tile_mode: Globals.SetTileMode = Globals.SetTileMode.OVERRIDE_ALL
) -> void:
	if preset == "":
		return

	var tile: Tile

	if set_tile_mode == Globals.SetTileMode.OVERRIDE_ONLY_WITH_COLLISION:
		var current_tiles: Array[Tile] = get_tiles(pos)
		## There are no tiles with has_collision == true.
		if not Utils.any_of_array_has_propriety_with_value(current_tiles, "has_collision", true):
			return
	
	if set_tile_mode == Globals.SetTileMode.OVERRIDE_ONLY_WITH_NOT_COLLISION:
		var current_tiles: Array[Tile] = get_tiles(pos)
		## There are no tiles with has_collision == false.
		if not Utils.any_of_array_has_propriety_with_value(current_tiles, "has_collision", false):
			return
	
	tile = tile_scene.instantiate()
	tile.preset_name = preset
	tile.copy_basic_proprieties(tiles_presets.get_tile_preset(preset))
	tile.grid_position = pos
	layers.get_current_layer().tiles.set_tile(tile)


## Return tiles from current layer on pos
func get_tiles(pos: Vector2i) -> Array[Tile]:
	return layers.get_current_layer().get_tiles(pos)


## Load object property from `dict` parameter. 
func load(data: Dictionary) -> void:
	raw_data = data

	# Load textures.
	if not data.has("textures"):
		Utils.print_warning("Game without a texture list.")
	else:
		textures.load(data["textures"])

	# Load tiles_presets
	if not data.has("tiles_presets"):
		Utils.print_warning("Game without a tile preset list.")
	else:
		tiles_presets.load(data["tiles_presets"])

	# Load layers.
	if not data.has("layers"):
		Utils.print_warning("Game without layers.")
	else:
		layers.load(data["layers"])

	# Load player.
	player = load("res://scenes/entities/player.tscn").instantiate()
	if not data.has("player"):
		Utils.print_warning("Game without a player.")
	else:
		player.load(data["player"])


	Utils.copy_from_dict_if_exists(
		self,
		data,
		["turn"],
		["turn"]
	)


func serialize() -> Dictionary:
	var result: Dictionary = super.serialize()
	return result
