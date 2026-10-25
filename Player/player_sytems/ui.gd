extends Control
class_name PlayerUI

@onready var interact_label: Label = $"Interact label"


func _ready() -> void:
	interact_label.text = "press \"%s\" to interact" % InputMap.action_get_events("interact")[0].as_text()[0]

func show_interact_label():
	interact_label.show()

func hide_interact_label():
	interact_label.hide()
