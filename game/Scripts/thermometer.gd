extends Node2D


# Called when the node enters the scene tree for the first time.
#var change_in_heat = 0.000001
var change_in_heat = 0.000001
var temperature = 20
func _ready() -> void:
	log_temp()
	pass # Replace with function body.

func log_temp():
	while (true):	
		await get_tree().create_timer(1).timeout
		print(temperature)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	temperature += change_in_heat
	change_in_heat += 0.00001
	queue_redraw()
	pass

func _draw():
	# Define the rectangle's position and size
	var rect_position = Vector2(0, 0-temperature*2.5)  # Change this to your desired position
	var rect_size = Vector2(8, temperature*2.5)  # Width is 200, height is the float value

	# Define the rectangle's color (red in this case)
	var rect_color = Color(1, 0, 0)  # RGB for red

	# Draw the rectangle
	draw_rect(Rect2(rect_position, rect_size), rect_color)
