extends CanvasLayer

var player = null	
class_name Dialogues

func _ready():
	
	SignalsGateway.connect("interacted", self, "_on_DisgustingWell_interacted")
	print("signals loaded")
	
func _on_DisgustingWell_interacted(body, target):	
	
	print("signal received from ", target, " to >>>> ", body)
	
	if target.name == "DisgustingWell":
		$DialogueBox.start()
		Globals.mouseLocked = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		body.set_physics_process(false)
		body.set_process_input(false)
		player = body
	else:
		print('thats not damn well')

func _on_DialogueBox_dialogue_ended():
	pass # Replace with function body.
	Globals.mouseLocked = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player.set_physics_process(true)
	player.set_process_input(true)
	player = null

func get_signals():
	
	var interactable_objects = get_tree().get_nodes_in_group("Interactable")
	for obj in interactable_objects:
		obj.connect("interacted", self, "interacted")
		print("singal connected for: ", obj)
	print("dialogues ready")


