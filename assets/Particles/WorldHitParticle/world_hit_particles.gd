extends GPUParticles3D
class_name world_gun_particle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emitting = true

func set_material(material : Material):
	draw_pass_1.material = material

func reset_material():
	draw_pass_1.material = Material.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_finished() -> void:
	queue_free()
