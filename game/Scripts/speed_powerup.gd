extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	%WaterDropSound.play()
	
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
		collider.on_speed_up()
		
