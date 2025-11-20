extends Node2D
class_name LevelLoader


@onready var level_parser: LevelParser = LevelParser.new()


func _ready():
	level_parser.load_from_path("/home/gustavo/Repositories/Personal/roguelike/data/level1.json")

	if level_parser.error == OK:
		# print(level_parser.data.textures["player"])
		# sprite.position = get_viewport_rect().get_center()
		# sprite.texture = level_parser.data.textures["default"]
		# print(level_parser.data.textures)
		for key in level_parser.data.tilemap:
			add_child(level_parser.data.tilemap[key])
	else:
		printerr("Parser error: %s" % level_parser.error_message)
