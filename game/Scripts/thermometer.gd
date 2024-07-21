extends Node2D

@onready var ice_cube: Sprite2D = $IceCube
const ICE_CUBE_1 = preload("res://Assets/IceCube1.png")
const ICE_CUBE_2 = preload("res://Assets/IceCube2.png")
const ICE_CUBE_3 = preload("res://Assets/IceCube3.png")
# Called when the node enters the scene tree for the first time.
#var change_in_heat = 0.000001
var change_in_heat = 0.000001
var temperature = 5
var too_hot = 250
func _ready() -> void:
	#log_temp()
	pass # Replace with function body.

func shoot_fireball():
	temperature += 16

func snowflake_collected():
	temperature -= 32
	if temperature < 5: temperature = 5
	
func tilt():
	if temperature + 5 < too_hot:
		temperature += 5
		
func log_temp():
	while (true):	
		await get_tree().create_timer(1).timeout
		#print(temperature)addddddd
		
@onready var ui: UI = $"../UI"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	temperature += change_in_heat
	change_in_heat += 0.00001
	queue_redraw()
	if temperature > too_hot:
		temperature = too_hot
		ui.game_over("TOO HOT! YOUR PALS MELTED!")
	
	ice_cube.texture = ICE_CUBE_1
	if temperature > 100:
		ice_cube.texture = ICE_CUBE_2
	if temperature > 200:
		ice_cube.texture = ICE_CUBE_3

func _draw():
	# Define the rectangle's position and size
	var rect_position = Vector2(0, 0-temperature*2.5)  # Change this to your desired position
	var rect_size = Vector2(32, temperature*2.5)  # Width is 200, height is the float value

	# Define the rectangle's color (red in this case)
	var rect_color = Color(0.9453125, 0.0859375, 0.015625)  # RGB for red

	# Draw the rectangle
	draw_rect(Rect2(rect_position, rect_size), rect_color)
