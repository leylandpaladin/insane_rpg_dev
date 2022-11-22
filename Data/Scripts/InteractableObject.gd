class_name Interactable
extends Node

onready var timer = $Timer

export var promt_message = "Interact"
export var promt_action = "Interact"
export var obj_name = "Generic"


func get_interaction_text():
	return promt_message

func interact(body):
	print(body, " <<<<< interacted with >>>>> ", self)
	SignalsGateway.emit_signal("interacted", body, self)
	print("signal emited to: ", body, " from ", self)
	print("OBJ_NAME IS: ", self.obj_name)
	





