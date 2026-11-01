extends Control
class_name Inventory

var inventory : Array[InventorySlot]
const INVENTORY_SLOT = preload("uid://c6uewx65flx8")

var active_slot = 1

func _ready() -> void:
	inventory.resize(9)
	for i in inventory.size():
		var instance = INVENTORY_SLOT.instantiate() as InventorySlot
		add_child(instance)
		instance.remove_item()
		instance.slot_id = i
		instance.position_id = i
		instance.position.y = 50
		instance.set_pos_id(0, inventory.size())
		instance.is_dummy = i < 1
		inventory[i] = instance
		
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory()
	if Input.is_action_just_pressed("left") and visible:
		inventory[active_slot].close_interact_menu()
		active_slot = (active_slot - 1) % inventory.size()
		var change : int = 1
		if active_slot == 0: 
			active_slot = inventory.size() - 1
			change = 2
		for slot in inventory:
			slot.set_pos_id(change, inventory.size())
	if Input.is_action_just_pressed("right") and visible:
		inventory[active_slot].close_interact_menu()
		active_slot = (active_slot + 1) % inventory.size()
		var change : int = -1
		if active_slot == 0: 
			active_slot = 1
			change = -2
		for slot in inventory:
			slot.set_pos_id(change, inventory.size())
	if Input.is_action_just_pressed("interact") and visible:
		inventory[active_slot].toggle_interact_menu()
	

func toggle_inventory():
	if visible:
		visible = false
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		visible = true
		for i in inventory.size():
			inventory[i].position_id = i
			inventory[i].set_pos_id(0, inventory.size())
		get_tree().paused = true

func remove_item_from_active_slot():
	var slot : InventorySlot = inventory[active_slot]
	if not slot.is_dummy and slot.is_filled:
		slot.item_name = "None"
		slot.item_icon = null
		slot.item_count = 0
		slot.is_filled = false
		return
	return

func remove_item(item_name : String):
	for i in inventory.size():
		var slot : InventorySlot = inventory[i]
		if slot.item_name == item_name:
			slot.item_name = "None"
			slot.item_icon = null
			slot.item_count = 0
			slot.filled = false
			return
	return

func get_item_count(item : String) -> int:
	for slot in inventory:
		if slot.item_name == item:
			return slot.item_count
	return 0

func add_count_to_active_slot(item : String, count : int) -> int:
	var slot = inventory[active_slot]
	if not slot.is_dummy and slot.is_filled:
		slot.item_count += count
		if slot.item_count <= 0: remove_item_from_active_slot()
		return 0
	
	return 1

func add_count(item : PickupItem) -> int:
	for i in inventory.size():
		var slot : InventorySlot = inventory[i]
		if slot.item_name == item.item_name:
			slot.item_count += item.item_count
			return 0
	
	for i in inventory.size():
		var slot : InventorySlot = inventory[i]
		if not slot.is_dummy and not slot.is_filled:
			slot.is_filled = true
			slot.item_name = item.item_name
			slot.item_count = item.item_count
			slot.item_icon = item.item_icon
			return 0
	
	return 1
