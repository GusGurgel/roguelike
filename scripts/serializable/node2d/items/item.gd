extends Tile
class_name Item

@export var usable: bool = false
@export var equippable: bool = false
@export var equipped: bool = false
@export var type: String = "default"
@export var description: String = "default"

signal on_unequip

var layer: Layer


func _init(_layer: Layer):
	layer = _layer


func _ready():
	super._ready()
	is_transparent = true
	has_collision = false


func use() -> void:
	print("Using %s..." % tile_name)
	queue_free()


func equip() -> void:
	equipped = true


func unequip() -> void:
	equipped = false
	on_unequip.emit()

# func drop():
# 	grid_position = Globals.game.player.grid_position
# 	# var item_was_drop = Globals.game.get_current_layer().set_item(self)

# 	return item_was_drop

################################################################################
# Serialization
################################################################################

func load(data: Dictionary) -> void:
	super.load(data)
	# var item_data = itens_data[item_key]
	# var node: Node = null
	# if Utils.dict_has_and_is_equal_lower_string(item_data, "type", "healing_potion"):
	# 	node = item_healing_potion_scene.instantiate()
	# 	Utils.copy_from_dict_if_exists(
	# 		node,
	# 		item_data,
	# 		[
	# 			"health_increase"
	# 		]
	# 	)
	# elif Utils.dict_has_and_is_equal_lower_string(item_data, "type", "melee_weapon"):
	# 	node = item_melee_weapon_scene.instantiate()
	# 	Utils.copy_from_dict_if_exists(
	# 		node,
	# 		item_data,
	# 		[
	# 			"damage"
	# 		]
	# 	)
	# else:
	# 	node = item_scene.instantiate()
	# var node_item = node as Item
	# if node_item:
	# item_data["tile"]["grid_position"] = {
	# 	x = grid_position.x,
	# 	y = grid_position.y
	# }
	# parse_item(item_data, node_item)
	# itens[item_key] = node_item


func serialize() -> Dictionary:
	var result: Dictionary = super.serialize()
	return result