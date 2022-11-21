class_name Interactable
extends Node

onready var timer = $Timer

export var promt_message = "Interact"
export var promt_action = "Interact"


func get_interaction_text():
	return promt_message

func interact(body):
	print(body, " <<<<< interacted with >>>>> ", name)
	SignalsGateway.emit_signal("interacted", body)
	print("signal emited")
	


