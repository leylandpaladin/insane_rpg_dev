extends CanvasLayer

var player = null

func _ready():
	
	var well = $"../DisgustingWell"
	well.connect("interacted", self, "_on_Disgusting_well_interacted")
	

func _on_Disgusting_well_interacted(body):
	print("signal recieved")
	$DialogueBox.start()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	body.set_physics_process(false)
	body.set_process_input(false)
	player = body
	


func _on_DialogueBox_dialogue_ended():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player.set_physics_process(true)
	player.set_process_input(true)
	player = null


