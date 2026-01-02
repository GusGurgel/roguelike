extends Item
class_name HealingPotion

@export var health_increase: int = 0

func _ready() -> void:
	super._ready()
	equippable = false
	usable = true


func use() -> void:
	Globals.game.player.health += health_increase

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
