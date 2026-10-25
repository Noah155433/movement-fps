@tool

class_name OmniData
extends Light3DData

@export_category("OmniLight3D")
@export_group("Omni", "omni_")
@export_range(0, 4096, 0.01, "or_greater", "exp") var omni_range : float = 5
@export_range(-16, 16, 0.01, "or_greater", "or_less") var omni_attenuation : float = 1
@export_enum("Dual Paraboloid", "Cube") var omni_shadow_mode : int = 1
