extends Sprite2D
class_name Tile

static var tile_scene = preload("res://scenes/tile.tscn")


var grid_position: Vector2i = Vector2i(0, 0):
	set(new_grid_position):
		position = Utils.grid_position_to_global_position(new_grid_position)
		grid_position = new_grid_position

var is_explored: bool = true

var is_in_view: bool = true:
	set(new_is_in_view):
		if new_is_in_view:
			is_explored = true
			visible = true
			modulate.a = 1
		else:
			if is_explored:
				modulate.a = 0.4
			else:
				visible = false

		is_in_view = new_is_in_view

var has_collision = false

## Tile used as a base. [br][br]
##
## It takes this parameters into account: [i][b]texture, has_collision, modulate (color)[/b][/i].
var preset: Tile:
	set(new_preset):
		preset = new_preset
		texture = preset.texture
		has_collision = preset.has_collision
		modulate = preset.modulate

func _ready():
	centered = false


## Return a new tile instance with the tile parameters
static func clone(tile: Tile) -> Tile:
	var clone_tile: Tile = tile_scene.instantiate()

	clone_tile.texture = tile.texture
	clone_tile.modulate = tile.modulate
	clone_tile.has_collision = tile.has_collision
	clone_tile.is_explored = tile.is_explored
	clone_tile.is_in_view = tile.is_in_view

	return clone_tile
