extends CharacterBody2D


# If it's dumb but it works it's not dunb
func weighted_random(weights: Array):
	var sum = weights.reduce(func(accum, number): return accum + number, 0)
	var rnd = randf_range(0,sum)
	var index_select = 1; var weights_cumulative = 0
	for n in weights:
		weights_cumulative += n
		if rnd >= weights_cumulative:
			index_select += 1
		else:
			index_select -= 1
			return index_select

enum  { speed_power, cold_power, bomb_power}
var sprites: Array[Texture2D] = [
	preload("res://Assets/SpeedPower.png"),
	preload("res://Assets/ColdPower.png"),
	preload("res://Assets/BombPower.png"),
]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var type := speed_power
func _ready() -> void:
	%WaterDropSound.play()
	
	type = weighted_random([20,40,10])
	if type == bomb_power:
		velocity.y = -800
		velocity.x += randf_range(-200,-50); if randf() < 0.5: velocity.x *= -1
		
	$Sprite2D.texture = sprites[type]
	
func _physics_process(delta: float) -> void:
	if velocity.y > 3000: 
		queue_free()

	velocity.y += gravity * delta
	var collision = move_and_collide(velocity * delta)
	if (!collision):
		return
	var collider = collision.get_collider()

	if ( collider is Paddle):
		queue_free()
		if type == speed_power:
			collider.on_speed_up()
		if type == cold_power:
			collider.on_temperature_down()
		if type == bomb_power:
			collider.on_bomb_power()

var scene_to_instance = preload("res://Scenes/bomb_blast.tscn")
func _on_area_2d_body_entered(body: Node2D) -> void:
	if type == bomb_power and body is Brick and velocity.y > 0.1:
		var object := scene_to_instance.instantiate()
		get_parent().add_child(object)
		object.position = position
		queue_free()
