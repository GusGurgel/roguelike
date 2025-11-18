extends Node2D
class_name LevelLoader


@onready var level_parser: LevelParser = LevelParser.new()

@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	level_parser.load_from_path("/home/gustavo/Repositories/Personal/roguelike/data/level1.json")

	if level_parser.error == OK:
		print(level_parser.data.textures["player"])
	else:
		printerr("Parser error: %s" % level_parser.error_message)

	sprite.position = get_viewport_rect().get_center()
	sprite.texture = level_parser.data.textures["player"]
