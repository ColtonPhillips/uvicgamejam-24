extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var sprites: Array[Texture2D] = [
	preload("res://Assets/SpeedPower.png"),
	preload("res://Assets/ColdPower.png"),
]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var type = 0
func _ready() -> void:
	%WaterDropSound.play()
	if (randf() > 0.3):
		type = 1
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
		if type == 0:
			collider.on_speed_up()
		if type == 1:
			collider.on_temperature_down()
		
