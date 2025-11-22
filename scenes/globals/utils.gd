extends Node
## Utils functions

## Checks if a dictionary has all keys
func dictionary_has_all(dict: Dictionary, keys: Array[String]) -> bool:
	for key in keys:
		if not dict.has(key):
			return false
	
	return true

## Converts integer grid position to a global position
func grid_position_to_global_position(grid_position: Vector2i) -> Vector2:
	return grid_position * Globals.tile_size

## Converts float global position to a integer grid_position
func global_position_to_grid_position(global_position: Vector2) -> Vector2i:
	return Vector2(
		global_position.x / Globals.tile_size.x,
		global_position.y / Globals.tile_size.y
	)


## Print a rich warning message
func print_warning(message: String):
	print_rich("[color=#ffff00]⚠ Warning: %s[/color]" % message)
