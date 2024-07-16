extends RigidBody2D

class_name Brick

signal brick_destroyed

var level = 1
var chance_to_spawn_power = 25

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D

var sprites: Array[Texture2D] = [
	preload("res://Assets/BrickYellow.png"),
	preload("res://Assets/BrickBlue.png"),
	preload("res://Assets/BrickOrange.png"),
	preload("res://Assets/BrickGreen.png"),
	preload("res://Assets/BrickRed.png"),
	preload("res://Assets/BrickWhite.png")
]

func get_size():
	return collision_shape_2d.shape.get_rect().size
	

func set_level(new_level: int):
	if (new_level < 1): new_level = 1
	level = new_level
	sprite_2d.texture = sprites[new_level - 1]
	
func decrease_level():
	if level > 1:
		set_level(level - 1)
	else: 
		fade_out()
		
func fade_out():
	%BreakSound.play()
	collision_shape_2d.disabled = true
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.TRANSPARENT, .25)
	tween.tween_callback(destroy)
	
var scene_to_instance = preload("res://Scenes/speed_powerup.tscn")
func destroy():
	queue_free()
	brick_destroyed.emit()
	if randi_range(0,100) < chance_to_spawn_power:
		var object := scene_to_instance.instantiate()
		get_parent().add_child(object)
		object.position = position
	
func get_width():
	return get_size().x

	

