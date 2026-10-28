extends CharacterBody3D
class_name Player

@export_category("Movement")
@export var speed : float = 2.0
@export var run_speed: float = 3.5
var running : bool = false
@export_category("Camera")
@export var camera : Camera3D
@export var sensitivity : float = 0.01
@export var joy_sensitivity : float = 3
var joy_right_vel : Vector2 = Vector2(0.0, 0.0)
@export_category("Player")
@export var health : int = 100
@export_category("UI")
@export var ui : PlayerUI
@export_category("misc")
@export var interact_ray : RayCast3D
var inventory : Inventory = Inventory.new()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	inventory.add_count("pistol_ammo", 10)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and interact_ray.is_colliding():
		var collider = interact_ray.get_collider()
		if collider is door:
			collider.open_door()
	
	if interact_ray.is_colliding() and interact_ray.get_collider() != null:
		var collider = interact_ray.get_collider()
		if collider.is_in_group("interactable"):
			ui.show_interact_label()
		else:
			ui.hide_interact_label()
	else:
		ui.hide_interact_label()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	running = true if Input.is_action_pressed("sprint") else false
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * (run_speed if running else speed)
		velocity.z = direction.z * (run_speed if running else speed)
	else:
		velocity.x = move_toward(velocity.x, 0, (run_speed if running else speed))
		velocity.z = move_toward(velocity.z, 0, (run_speed if running else speed))
	
	#Camera up down with joy
	camera.rotation.x += joy_right_vel.y * sensitivity
	camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
		
	#Camera left right (rotates player)
	rotation.y += -joy_right_vel.x * sensitivity
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		
		joy_right_vel = Vector2.ZERO
		
		var mouse_movement = event.screen_relative
		
		#Camera up down with mouse
		camera.rotation.x += -mouse_movement.y * sensitivity
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
		
		#Camera left right (rotates player)
		rotation.y += -mouse_movement.x * sensitivity
		
	elif event is InputEventJoypadMotion:
		
		if event.get_axis() == JOY_AXIS_RIGHT_X:
			if abs(event.get_axis_value()) < 0.2:
				joy_right_vel.x = 0
			else:
				joy_right_vel.x = event.get_axis_value() * joy_sensitivity
		if event.get_axis() == JOY_AXIS_RIGHT_Y:
			if abs(event.get_axis_value()) < 0.2:
				joy_right_vel.y = 0
			else:
				joy_right_vel.y = -event.get_axis_value() * joy_sensitivity

func take_damage(damage : int):
	health -= damage
	if health <= 0:
		queue_free()

func heal_damage(damage : int):
	health += damage
