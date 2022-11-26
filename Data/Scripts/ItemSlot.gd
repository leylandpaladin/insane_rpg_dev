extends ColorRect

onready var icon = $Icon
onready var quantity = $Quantity

func display_item(item):
	if item:
		quantity.text = str(item.quantity) if item.stackable else ""
	else:
		quantity.text = null
