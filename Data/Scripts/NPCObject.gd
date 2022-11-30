extends Interactable


enum NPCTYPE {NONE = -1, HUMANOID = 0, UNDEAD = 1, DEMON = 2, BEAST = 3, CORPSE = 4}
enum FACTION {NONE = -1, AGNOSTIC = 0, DEVOUT = 1, HERETIC = 2}


export (NPCTYPE) var NpcType
export (FACTION) var Faction

export var hostile := false
export var health := 100
export var mana :=100
export var level := 1

var dead := false

export var dialog_index = 0

onready var animation_player = $StaticBody/AnimationPlayer

func _process(delta):
	
	if health <= 0:
		death()
		
	
func death():
	
	if not dead:
		animation_player.play("death")
		dead = true
		animation_player.clear_queue()
		NpcType = NPCTYPE.CORPSE
