extends Resource
class_name Level
## Represents a parsed game level. This contains everything to the game runs.


## Just the JSON parsed to a Dictionary
var raw_data: Dictionary
var player: Player
## Dictionary of game textures
var textures: Dictionary[String, AtlasTexture]
