extends Node

signal items_changed(indexes)
signal item_count_changed(item_count)

## Test items
## TODO: make provider and logic for resources
onready var sword = preload("res://Data/Resources/Items/Weapons/Sword.tres")
onready var health_potion = preload("res://Data/Resources/Items/Potions/Health.tres")

var currentSlotId = -1
var cols := 8
var rows := 4
var slots := cols * rows
var items = []
var visible = false
var item_count = 0

func _ready():
	for i in range(slots):
		items.append(null)
	items[0] = sword.duplicate()
	items[1] = health_potion.duplicate()
	items[2] = health_potion.duplicate()
	items[2].quantity = 5
	get_initial_item_count()
	
	
func set_item(index, item):
	var previous_item = items[index]
	items[index] = item
	emit_signal("items_changed", [index])
	emit_signal("item_count_changed", item_count)
	return previous_item

func remove_item(index):
	var previous_item = items[index].duplicate()
	items[index] = null
	emit_signal("items_changed", [index])
	emit_signal("item_count_changed", item_count)
	return previous_item
	
func set_item_quantity(index, amount):
	items[index].quantity += amount
	if items[index].quantity <= 0:
		remove_item(index)
	else:
		emit_signal("items_changed", [index])
		
func get_initial_item_count():
	for item in items:
		if (item != null):
			item_count += 1
