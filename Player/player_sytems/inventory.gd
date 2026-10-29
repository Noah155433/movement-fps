extends Control
class_name Inventory

class InventorySlot:
	var item_name : String = "None"
	var item_count : int = 0
	
	func _init(name : String, count : int) -> void:
		item_name = name
		item_count = count

var inventory : Array[InventorySlot]

func _init() -> void:
	inventory.resize(6)
	for i in inventory.size():
		inventory[i] = InventorySlot.new("None", 0)

func print_inventory():
	for slot : InventorySlot in inventory:
		print(slot.item_name)
		print(slot.item_count)

func remove_item(item_name : String):
	for i in inventory.size():
		var slot : InventorySlot = inventory[i]
		if slot.item_name == item_name:
			slot.item_name = "None"
			slot.item_count = 0
			return
	return

func get_item_count(item : String) -> int:
	for slot in inventory:
		if slot.item_name == item:
			return slot.item_count
	return 0

func add_count(item : String, count : int) -> int:
	for i in inventory.size():
		var slot : InventorySlot = inventory[i]
		if slot.item_name == item:
			slot.item_count += count
			return 0
	
	for i in inventory.size():
		var slot : InventorySlot = inventory[i]
		if slot and slot.item_name == "None":
			slot.item_name = item
			slot.item_count = count
			return 0
	
	return 1
