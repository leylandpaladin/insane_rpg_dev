extends WorldEnvironment

onready var anim = $AnimationPlayer

func _ready():

	anim.play("cycle")
