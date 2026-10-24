extends Node3D

@export_category("nodes")
@export var gun_ray : RayCast3D
@export var world_hit_particle : PackedScene
@export var fire_rate_timer : Timer
@export var reload_timer : Timer

@export_category("weapon settings")
@export var max_ammo : int = 13
@export var fire_rate : float = 0.1
@export var reload_time : float = 1.5
@export var has_gun : bool = true
var ammo : int
var fire_rate_zero : bool = true
var reloading : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ammo = max_ammo
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var can_fire : bool = fire_rate_zero and not reloading and has_gun
	
	if Input.is_action_just_pressed("shoot") and ammo > 0 and can_fire:
		shoot()
	if Input.is_action_just_pressed("reload"):
		reload()
	

func reload():
	reloading = true
	reload_timer.start(reload_time)

func shoot():
	ammo -= 1
	fire_rate_zero = false
	fire_rate_timer.start(fire_rate)
	if gun_ray.is_colliding():
		var collider = gun_ray.get_collider()
		if collider is enemyTest:
			collider.take_damage()
		var instance = world_hit_particle.instantiate()
		(instance as GPUParticles3D).position = gun_ray.get_collision_point()
		get_tree().root.add_child(instance)
	

func _on_fire_rate_timer_timeout() -> void:
	fire_rate_zero = true
	

func _on_reload_timer_timeout() -> void:
	reloading = false
	ammo = max_ammo
	
