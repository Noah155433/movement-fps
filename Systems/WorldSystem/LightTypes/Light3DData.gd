@tool

class_name Light3DData
extends Resource

@export_category("Light3D")
@export_group("Light", "light_")
@export var light_color : Color = Color.WHITE
@export_range(0, 16, 0.01, "or_greater") var light_energy : float = 1.0
@export_range(0, 16, 0.01) var light_indirect_energy : float = 1.0
@export_range(0, 16, 0.01, "or_greater") var light_volumetric_fog_energy : float = 1.0
@export var light_projector : Texture2D = null
@export_range(0, 10, 0.01, "suffix:m") var light_size : float = 0.0
@export var light_negative : bool = false
@export_range(0, 16, 0.01) var light_specular : float = 0.5
@export_enum("Disabled", "Static", "Dynamic") var light_bake_mode : int = 2

@export_group("Shadow", "shadow_")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var shadow_shadow : bool = false
@export_range(0, 10, 0.01) var shadow_bias : float = 0.1
@export_range(0, 10, 0.01) var shadow_normal_bias : float = 1.0
@export var shadow_reverse_cull_face : bool = false
@export_range(-16, 16, 0.01) var shadow_transmittance_bias : float = 0.05
@export_range(0, 1, 0.01) var shadow_opacity = 1.0
@export_range(0, 10, 0.01) var shadow_blur = 1.0

@export_group("Distance Fade", "distance_fade_")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var distance_fade_distance_face : bool = false
@export_range(0, 4096, 0.01, "or_greater") var distance_fade_begin : float = 40.0
@export_range(0, 4096, 0.01, "or_greater") var distance_fade_shadow : float = 50.0
@export_range(0, 4096, 0.01, "or_greater") var distance_fade_length : float = 10.0

@export_group("Editor", "editor_")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var editor_editor : bool = false
@export var editor_editor_only : bool = false
