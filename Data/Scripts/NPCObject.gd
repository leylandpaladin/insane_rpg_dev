extends Interactable


enum NPCTYPE {NONE = -1, HUMANOID = 0, UNDEAD = 1, DEMON = 2, BEAST = 3}
enum FACTION {NONE = -1, AGNOSTIC = 0, DEVOUT = 1, HERETIC = 2}


export (NPCTYPE) var NpcType
export (FACTION) var Faction

export var hostile := false
export var health := 100
export var mana :=100
export var level := 1

export var dialog_index = 0

