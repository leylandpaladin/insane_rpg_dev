extends ColorRect

onready var icon = $Icon
onready var quantity = $Quantity

func display_item(item):
	if item:
		icon.texture = load("res://icon.png")
		quantity.text = str(item.quantity) if item.stackable else ""
	else:
		icon.texture = null
		quantity.text = ""
