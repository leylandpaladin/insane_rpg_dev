extends Panel

const donutMaskSizeMin := 2.17
const donutMaskSizeMax := 2.25
const shaderSpeed := 0.9

onready var icon = $Icon
onready var quantity = $Quantity
onready var shader = $Icon/ColorRect.material
var fadeAmount := 2.3
var fadeIn := false


func _process(_delta):
		fade_shader(_delta)

func display_item(item):
	if item:
		icon.texture = item.icon
		quantity.text = str(item.quantity) if item.stackable else ""
	else:
		icon.texture = null
		quantity.text = ""
		

func fade_shader(_delta):
	if !Inventory.visible:
		shader.set("shader_param/DonutMaskSize", donutMaskSizeMax)
	if fadeIn && fadeAmount > donutMaskSizeMin:
		fadeAmount -= shaderSpeed * _delta
		shader.set("shader_param/DonutMaskSize", clamp(fadeAmount, donutMaskSizeMin, donutMaskSizeMax))
	elif !fadeIn && fadeAmount < donutMaskSizeMax:
		fadeAmount += shaderSpeed * _delta
		shader.set("shader_param/DonutMaskSize", clamp(fadeAmount, donutMaskSizeMin, donutMaskSizeMax))


func _on_ItemSlot_mouse_entered():
	fadeIn = true

func _on_ItemSlot_mouse_exited():
	fadeIn = false
	#print(shader.get("shader_param/DonutMaskSize"))
