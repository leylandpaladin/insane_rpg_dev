extends PanelContainer

onready var slots = $VBoxContainer/InfoPanel/HBoxContainer/Slots

func _ready():
	rect_position = (get_viewport_rect().size - rect_size) / 1.8
	
func _process(_delta):
	slots.set_text(str("Slots: %d/24" % [Inventory.item_count]))
