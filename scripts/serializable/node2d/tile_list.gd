extends SerializableNode2D
class_name TileList

var tiles: Dictionary[String, Tile]
var layer: Layer


func _init(_layer: Layer):
	layer = _layer


func get_tile(pos: Vector2i) -> Tile:
	return tiles.get(Utils.vector2i_to_string(pos))


func set_tile(tile: Tile) -> void:
	var pos_key: String = Utils.vector2i_to_string(tile.grid_position)

	if tiles.has(pos_key):
		erase_tile(tile.grid_position)
	tiles[pos_key] = tile

	## Add tile or reparent to the current layer.
	if tile.get_parent():
		tile.reparent(self)
	else:
		add_child(tile)


	layer.astar_grid.set_point_solid(tile.grid_position, tile.has_collision)


func erase_tile(pos: Vector2i) -> bool:
	var pos_key: String = Utils.vector2i_to_string(pos)

	if tiles.has(pos_key):
		tiles[pos_key].queue_free()
		tiles.erase(pos_key)
		layer.astar_grid.set_point_solid(pos, false)
		return true
	else:
		return false

################################################################################
# Serialization
################################################################################

func load(data: Dictionary) -> void:
	super.load(data)
	
	for tile_key in data:
		var tile: Tile = Tile.new()
		var tile_data: Dictionary = data[tile_key]
		var grid_position: Vector2i = Utils.string_to_vector2i(tile_key)
		tile_data["grid_position"] = {
			x = grid_position.x,
			y = grid_position.y
		}
		tile.load(tile_data)
		set_tile(tile)


func serialize() -> Dictionary:
	var result: Dictionary = super.serialize()

	for tile_key in tiles:
		result[tile_key] = tiles[tile_key].serialize()

	return result
