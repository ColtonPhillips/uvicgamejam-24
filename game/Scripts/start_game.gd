extends Node

@onready var comic_button: TextureButton = $ComicButton
@onready var camera_2d: Camera2D = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	cutscene()
	
func cutscene():
	var timing := 4
	
	await get_tree().create_timer(3).timeout
	camera_2d.position = Vector2(465, 431)
	camera_2d.rotation_degrees += randf_range(-10,10)
	
	await get_tree().create_timer(timing).timeout
	camera_2d.position = Vector2(1250, 445)
	camera_2d.rotation_degrees += randf_range(-10,10)
	
	await get_tree().create_timer(timing).timeout
	camera_2d.position = Vector2(2050, 465)	
	camera_2d.rotation_degrees += randf_range(-10,10)
	

	await get_tree().create_timer(timing).timeout
	camera_2d.position = Vector2(891, 940)
	camera_2d.rotation_degrees += randf_range(-10,10)
	if camera_2d.rotation_degrees > 20: camera_2d.rotation_degrees -= 10
	if camera_2d.rotation_degrees < -20: camera_2d.rotation_degrees += 10
	
	await get_tree().create_timer(timing).timeout
	camera_2d.position = Vector2(1777, 1021)
	camera_2d.rotation_degrees += randf_range(-10,10)
	
	await get_tree().create_timer(timing).timeout
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(camera_2d, "zoom", Vector2(0.8,0.8), 3.3)
	camera_2d.position = Vector2(1366, -259)
	camera_2d.position_smoothing_speed = 1
	camera_2d.rotation_degrees += randf_range(-10,10)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("ui_accept"):
		_on_start_button_pressed()

func _on_texture_button_pressed() -> void:
	pass
	#comic_button.visible = false
