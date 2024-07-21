extends CanvasLayer

@onready var current_label: Label = $CurrentLabel
@onready var fastest_label: Label = $FastestLabel

@onready var current_time = 0.0 :
	set (x) : current_time = x; current_label.text =  "%.2f s" % (x) # str(x) # var time_string := "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

@onready var fastest_time = 0.0 :
	set (x) : fastest_time = x; fastest_label.text =  "HS: %.2f s" % (x) # str(x) # var time_string := "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

@onready var paused = false

static var ongoing_time = 0.0

func _ready() -> void:
	current_time = ongoing_time

func _process(delta: float) -> void:
	if not paused:
		current_time += delta
		ongoing_time = current_time

func reset_timer():
	current_time = 0
	paused = false
	ongoing_time = 0

func save_timer():
	SaveLoad.save_run(current_time)
	fastest_time = SaveLoad.fastest_run
	fastest_label.show()
	
func save_and_reset_timer():
	save_timer()
	reset_timer()

