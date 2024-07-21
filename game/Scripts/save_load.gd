extends Node

const save_file = "user://savefile.save"
var fastest_run = 9999999999999
func save_score():
	var file = FileAccess.open(save_file, FileAccess.WRITE_READ)
	file.store_float (fastest_run) # our current run is now our fastest run!
	print ("Saved fastest run %.2f" % fastest_run)

func load_score():
	var file = FileAccess.open(save_file, FileAccess.READ)
	if FileAccess.file_exists(save_file):
		fastest_run = file.get_float()
		print ("loaded fastest run %.2f" % fastest_run)

func _ready():
	load_score()

# dumb name?
func save_run(current_run):
	# upon clicking the game over button do
	if fastest_run > current_run or fastest_run == 0: # first time loading, its 0, meh
		fastest_run = current_run
	save_score()
