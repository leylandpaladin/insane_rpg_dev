extends Interactable


enum DOOR_STATUS {UNLOCKED = 0, LOCKED = 1, DESTRUCTABLE = 2}
enum LOCK_LEVEL {NONE = -1, EASY = 0, MEDIUM = 25, HARD = 50 }

export (DOOR_STATUS) var DoorType
export (LOCK_LEVEL) var LockLevel

export var InterlocationDoor = false
export var ScenePath :=""

