@tool

extends AreaLight3D
class_name FlickeringAreaLight3D

@export var on_time : float = 1.0
@export var off_time : float = 0.1
@export var on_time_variation : float = 0.0
@export var off_time_variation : float = 0.0

var flicker_timer: Timer


func _ready() -> void:
	get_tree().create_timer(on_time + randf_range(0, on_time_variation)).timeout.connect(_on_flicker_timer_timeout)

func _on_flicker_timer_timeout() -> void:
	if visible == true:
		visible = false
		
		get_tree().create_timer(off_time + randf_range(0, off_time_variation)).timeout.connect(_on_flicker_timer_timeout)
	else:
		visible = true
		get_tree().create_timer(on_time + randf_range(0, on_time_variation)).timeout.connect(_on_flicker_timer_timeout)
