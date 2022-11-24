class_name Interactable
extends Node

onready var timer = $Timer

export var promt_message = "Interact"
export var promt_action = "Interact"
export var obj_name = "Generic"

enum TYPE {DOOR = 0, NPC = 1, CONTAINER = 2, HAS_EFFECT = 3}
export (TYPE) var ObjectType


func get_interaction_text():
	return promt_message

func interact(body):
	print(body.name, " <<<<< interacted with >>>>> ", self.obj_name)
	SignalsGateway.emit_signal("interacted", body, self)
	print("signal emited to: ", body.name, " from ", self.obj_name)
	
	





