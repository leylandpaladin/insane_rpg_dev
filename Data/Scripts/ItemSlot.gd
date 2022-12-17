extends Panel

onready var icon = $Icon
onready var quantity = $Quantity
onready var shader = $Icon/ColorRect.material
var fadeAmount := 2.3
var fadeIn := false

func _process(_delta):
		fade_shader()

func display_item(item):
	if item:
		icon.texture = item.icon
		quantity.text = str(item.quantity) if item.stackable else ""
	else:
		icon.texture = null
		quantity.text = ""
		

func fade_shader():
	if !Inventory.visible:
		shader.set("shader_param/DonutMaskSize", 2.25)
	if fadeIn && fadeAmount > 2.17:
		fadeAmount -= 0.05
		shader.set("shader_param/DonutMaskSize", clamp(fadeAmount, 2.17, 2.25))
	elif !fadeIn && fadeAmount < 2.25:
		fadeAmount += 0.05
		shader.set("shader_param/DonutMaskSize", clamp(fadeAmount, 2.17, 2.25))


func _on_ItemSlot_mouse_entered():
	fadeIn = true

func _on_ItemSlot_mouse_exited():
	fadeIn = false
	#print(shader.get("shader_param/DonutMaskSize"))
