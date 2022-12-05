extends ColorRect

onready var icon = $Icon
onready var quantity = $Quantity
onready var shader = $Icon/ColorRect.material
var fadeAmount := 2.3
var fadeIn := false


func _process(_delta):
		fade()

func display_item(item):
	if item:
		icon.texture = item.icon
		quantity.text = str(item.quantity) if item.stackable else ""
	else:
		icon.texture = null
		quantity.text = ""
		

func fade():
	if fadeIn && fadeAmount > 2.05:
		fadeAmount -= 0.02
		shader.set("shader_param/DonutMaskSize", clamp(fadeAmount, 2.05, 2.3))
	elif !fadeIn && fadeAmount < 2.3:
		fadeAmount += 0.02
		shader.set("shader_param/DonutMaskSize", clamp(fadeAmount, 2.05, 2.3))


func _on_ItemSlot_mouse_entered():
		fadeIn = true

func _on_ItemSlot_mouse_exited():
	fadeIn = false
	print(shader.get("shader_param/DonutMaskSize"))
