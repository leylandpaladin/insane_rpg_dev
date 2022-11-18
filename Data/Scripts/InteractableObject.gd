
class_name Interactable
extends Node

onready var timer = $Timer

func get_interaction_text():
	return "Interact"

func interact():
	$MeshInstance.get_active_material(0).set_albedo(Color(1,0,0))
	print("Interacted with %s" % name)
	timer.set_wait_time(3)
	timer.start()


func _on_Timer_timeout():
	$MeshInstance.get_active_material(0).set_albedo(Color(0,0,1))
