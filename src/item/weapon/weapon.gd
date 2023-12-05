class_name Weapon extends Item

@export var soulstones: Array[SoulstoneSlot]
# Experience increases everytime a weapon of the same type drops.
# It also increase slightly everytime the weapon is used.
# And it increases moderately everytime the weapon attacks.
var level := 1 # Caps out at 9, the 10th level is for upgrading the tier
var experience := 0.0

func _init(_experience := 0.0, _level := 1):
	item_type = ItemType.WEAPON
	level = _level
	experience = _experience

func level_up():
	xp_to_level(level, experience)
	pass

func xp_to_level(current_level: int, current_xp: float):
	const multiplier = 100
	# log(100^x)^x*(x*100)
	# TODO: simplify function
	var required_xp = pow(
		log(pow(multiplier, current_level)), current_level
	) * (current_level * multiplier)
	if current_xp >= required_xp:
		xp_to_level(current_xp - required_xp, current_level + 1)
	else:
		level_to_grade(current_level)

func level_to_grade(current_level: int):
	# TODO: Require ascension points on the item in the future to upgrade
	var new_grade := current_level / 10.0
	var new_level = int(fmod(new_grade, 1) * 10)
	new_grade = new_grade - (new_level / 10.0)
	
	item_grade = Item.ItemGrade.keys()[new_grade]
	level = new_level
