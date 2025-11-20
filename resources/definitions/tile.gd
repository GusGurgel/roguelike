extends Sprite2D
class_name Tile

@export var grid_position: Vector2i = Vector2i(0, 0):
    set(new_grid_position):
        position = Utils.grid_position_to_global_position(new_grid_position)
        grid_position = new_grid_position

@export var is_explored: bool = true

@export var is_in_view: bool = true:
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


func _ready():
    centered = false
