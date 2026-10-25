@tool

class_name WorldSystemLight
extends Resource

enum Light_types {OMNI, SPOT, AREA, DIRECTIONAL}

@export var light_type : Light_types = Light_types.OMNI:
	set(new): light_type = new; new_light_type()
@export var omni_light : OmniData = null

var light_instance : Light3D = OmniLight3D.new()

func new_light_type():
	pass

func new_omni_light():
	var instance = OmniLight3D.new()
	instance.omni_range = omni_light.omni_range
	instance.omni_attenuation = omni_light.omni_attenuation
	instance.omni_shadow_mode = omni_light.omni_shadow_mode
	
	instance.light_color = omni_light.light_color
	instance.light_energy = omni_light.light_energy
	instance.light_indirect_energy = omni_light.light_indirect_energy
	instance.light_volumetric_fog_energy = omni_light.light_volumetric_fog_energy
	instance.light_projector = omni_light.light_projector
	instance.light_size = omni_light.light_size
	instance.light_negative = omni_light.light_negative
	instance.light_specular = omni_light.light_specular
	instance.light_bake_mode = omni_light.light_bake_mode
	
	instance.shadow_bias = omni_light.shadow_bias
	instance.shadow_normal_bias = omni_light.shadow_normal_bias
	instance.shadow_reverse_cull_face = omni_light.shadow_reverse_cull_face
	instance.shadow_transmittance_bias = omni_light.shadow_transmittance_bias
	instance.shadow_opacity = omni_light.shadow_opacity
	instance.shadow_blur = omni_light.shadow_blur
	
	instance.distance_fade_begin = omni_light.distance_fade_begin
	instance.distance_fade_shadow = omni_light.distance_fade_shadow
	instance.distance_fade_length = omni_light.distance_fade_length
	
	instance.editor_only = omni_light.editor_editor_only
	
	light_instance = instance
