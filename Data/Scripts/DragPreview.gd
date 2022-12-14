extends Control

var dragged_item = {} setget set_dragged_item

onready var item_icon = $Icon
onready var item_quantity = $Quantity

func _process(_delta):
	if dragged_item:
		rect_position = get_global_mouse_position()

func set_dragged_item(item):
	dragged_item = item
	if dragged_item:
		item_icon.texture = dragged_item.icon
		item_quantity.text = str(dragged_item.quantity) if dragged_item.stackable else ""
	else:
		item_icon.texture = null
		item_quantity.text = ""
