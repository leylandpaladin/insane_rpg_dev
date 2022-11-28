extends Interactable


enum EFFECTS {NONE = -1,TELEPORT = 0, SPECIAL = 99}
export (EFFECTS) var EffectDone

export var usedOnce := false

export var used_once_line := ""
export (float) var magnitude = 0
export var scene_string := ""


