extends Item
class_name RangeWeapon

var damage: int = 0
var mana_cost: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	equippable = true
	usable = false


func equip() -> void:
	if equipped:
		return
	super.equip()
	if Globals.game.player.range_weapon != null:
		Globals.game.player.range_weapon.unequip()

	Globals.game.player.range_weapon = self


func unequip() -> void:
	if not equipped:
		return
	super.unequip()
	Globals.game.player.range_weapon = null


func drop() -> bool:
	unequip()
	return super.drop()


func get_info() -> String:
	var info: String = super.get_info()

	info += """\nDamage: %s
Mana Cost: %s """ % [damage, mana_cost]

	return info

################################################################################
# Serialization
################################################################################

func load(data: Dictionary) -> void:
	super.load(data)
	Utils.copy_from_dict_if_exists(
		self,
		data,
		[
			"damage",
			"mana_cost"
		]
	)


func serialize() -> Dictionary:
	var result: Dictionary = super.serialize()
	return result
