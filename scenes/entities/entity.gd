extends Tile
class_name Entity

@export var max_health: int = 100
@export var health: int = 100:
	set(new_health):
		if new_health > max_health:
			health = max_health
		else:
			health = new_health

@export var entity_name: String = ""


func _ready() -> void:
	super._ready()
