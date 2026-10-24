extends StaticBody3D
class_name door

var door_is_open : bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var door_open_anim : Animation
@export var door_closed_anim : Animation

func _ready():
	animation_player.play(door_closed_anim.resource_name)

func open_door():
	if door_is_open: return
	animation_player.play(door_open_anim.resource_name)
	door_is_open = true

func close_door():
	animation_player.play_backwards(door_open_anim.resource_name)
	door_is_open = false


func _on_door_area_body_exited(body: Node3D) -> void:
	if body is player:
		close_door()
