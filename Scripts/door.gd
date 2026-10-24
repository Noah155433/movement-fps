extends StaticBody3D
class_name door

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var door_open_anim : Animation
@export var door_closed_anim : Animation

func _ready():
	animation_player.play(door_closed_anim.resource_name)

func _on_player_detection_body_entered(body: Node3D) -> void:
	if body is player:
		animation_player.play(door_open_anim.resource_name)
	

func _on_player_detection_body_exited(body: Node3D) -> void:
	if body is player:
		animation_player.play_backwards(door_open_anim.resource_name)
