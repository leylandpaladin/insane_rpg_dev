extends CanvasLayer

var player = null



func _on_Disgusting_well_interacted(body):
	print("signal recieved")
	$DialogueBox.start()
	body.set_physics_process(false)
	body.set_process_input(false)
	player = body
	


func _on_DialogueBox_dialogue_ended():
	player.set_physics_process(true)
	player.set_process_input(true)
	player = null


