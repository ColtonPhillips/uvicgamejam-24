extends Node

var current_level = 2

var level_1 = [
	[1,1,2,2,2,1,1],
	[1,1,3,3,3,1,1],
	[1,1,1,1,1,1,1],
]

var level_2 = [
	[0,1,2,3,2,3,2,1,0],
	[0,1,2,3,2,3,2,1,0],
	[0,0,0,0,0,0,0,0,0],
	[0,1,1,1,1,1,1,1,0],
	[0,1,1,1,1,1,1,1,0]
]

var levels = [level_1, level_2]

func get_current_level():
	print(levels[0])
	return levels[current_level - 1]

func is_last_level():
	return current_level == levels.size()
