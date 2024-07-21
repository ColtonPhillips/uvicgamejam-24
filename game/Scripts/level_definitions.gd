extends Node

var max_lives = 5
var lives = max_lives
var current_level = 1

var level_1 = [
	[1,1,2,0,2,1,1],
	[1,1,2,0,2,1,1],
	[1,1,1,1,1,1,1],
]

var level_2 = [
	[1,1,1,1,1,1,1,1,1],
	[1,0,0,0,0,0,0,0,1],
	[1,0,0,0,6,0,0,0,1],
	[1,0,0,0,0,0,0,0,1],
	[1,1,1,1,1,1,1,1,1],
]

var level_3 = [
	[1,0,0,0,1],
	[1,0,0,0,1],
	[1,0,0,0,1],
	[3,1,1,1,3],
	[3,3,3,3,3],
]

var level_4 = [
	[0,0,0,1,1,1,1,1,1],
	[0,0,0,1,1,1,1,1,2],
	[0,0,0,3,3,3,3,3,3],
]

var level_5= [
	[0,1,2,3,2,3,2,1,0],
	[0,1,2,3,2,3,2,1,0],
	[0,0,0,0,0,0,0,0,0],
	[0,1,1,1,1,1,1,1,0],
	[0,1,1,1,1,1,1,1,0]
]

var levels = [level_1, level_2, level_3, level_4, level_5]
#var levels = [level_1, level_2]

func get_current_level():
	return levels[current_level - 1]

func is_last_level():
	return current_level == levels.size()

func life_lost():
	lives -= 1
	
func reset_game():
	current_level = 1
	lives = max_lives
