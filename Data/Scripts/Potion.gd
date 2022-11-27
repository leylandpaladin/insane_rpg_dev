extends default_item
class_name Potion

enum PotionType { Health, Mana, Disease, Poison }
export(int) var tier = 1
export(PotionType) var potion_type
export(int) var power = 1 if tier < 2 else 2
