extends RigidBody2D

class_name Paddle

var direction = Vector2.ZERO
var camera_rect: Rect2
var half_paddle_width: float
var is_ball_started = false
var is_sped_up = false
@export var speed = 550
@export var camera: Camera2D
@onready var thermometer: Node2D = $"../Thermometer"

@onready var ball = $"../Ball" as Ball
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	ball.life_lost.connect(on_ball_lost)
	camera_rect = camera.get_viewport_rect()
	half_paddle_width = collision_shape_2d.shape.get_rect().size.x / 2 * scale.x

func _physics_process(delta):
	linear_velocity = speed * direction
	if is_sped_up:
		$Sprite2D.modulate.r = 0.5
		$Sprite2D.modulate.b = 1.5
		linear_velocity *= 2
	else:
		$Sprite2D.modulate.r = 1
		$Sprite2D.modulate.b = 1
		
func _process(delta):
	var camera_start_x = camera.position.x - camera_rect.size.x / 2
	var camera_end_x = camera_start_x + camera_rect.size.x
	
	if global_position.x - half_paddle_width < camera_start_x:
		global_position.x = camera_start_x + half_paddle_width
	elif global_position.x + half_paddle_width > camera_end_x:
		global_position.x = camera_end_x - half_paddle_width
	
var scene_to_instance = preload("res://Scenes/fire_ball.tscn")
func _input(event):
	if Input.is_action_just_pressed("shoot") and is_ball_started:
		var object := scene_to_instance.instantiate()
		thermometer.temperature += 5
		print(thermometer.temperature)
		get_parent().add_child(object)
		object.position = position 
		object.position.y -= 40
		
	var _d = Input.get_axis("left", "right")
	if _d == -1:
		direction = Vector2.LEFT
	elif _d == 1:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.ZERO
		
	if (direction != Vector2.ZERO or Input.is_action_just_pressed("shoot")) && !is_ball_started:
		ball.start_ball()
		is_ball_started = true

func on_ball_lost():
	is_ball_started = false
	direction = Vector2.ZERO

func get_width():
	return collision_shape_2d.shape.get_rect().size.x

func on_speed_up():
	if is_sped_up: return
	%SpeedPowerUpSound.play()
	is_sped_up = true
	await get_tree().create_timer(7.0).timeout
	is_sped_up = false

func on_temperature_down():
	thermometer.temperature -= 7

var sprites: Array[Texture2D] = [
	preload("res://Assets/PaddleCat.png"),
	preload("res://Assets/PaddleCatSquee.png"),
]
func squee():
	$Sprite2D.texture = sprites[1]
	await get_tree().create_timer(0.3).timeout
	$Sprite2D.texture = sprites[0]
	
