extends Node

signal items_changed(indexes)

## Test items
## TODO: make provider and logic for resources
onready var test_item = preload("res://Data/Resources/Items/Weapons/Sword.tres")

var cols := 8
var rows := 4
var slots := cols * rows
var items = []

func _ready():
	for i in range(slots):
		items.append({})
	items[0] = test_item.duplicate(true)
	
func set_item(index, item):
	var previous_item = items[index]
	items[index] = item
	emit_signal("items_changed", [index])
	return previous_item

func remove_item(index):
	var previous_item = items[index].duplicate(true)
	items[index].clear()
	emit_signal("items_changed", [index])
	return previous_item
	
func set_item_quantity(index, amount):
	items[index].quantity += amount
	if items[index].quantity <= 0:
		remove_item(index)
	else:
		emit_signal("items_changed", [index])
	
