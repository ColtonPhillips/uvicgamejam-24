extends CharacterBody2D

class_name Fireball
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	velocity.y = -170
	letsgo()
	
func letsgo():
	await get_tree().create_timer(7).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	
	velocity.y -= 580 * delta
	var collision = move_and_collide(velocity * delta)
	if (!collision):
		return
		
	var collider = collision.get_collider()
	if (collider is Brick):
		collider.decrease_level()
		queue_free()
	#if (collider is Wall):
		#queue_free()
	if (collider is Ball):
		collider.velocity.y = - abs(collider.velocity.y) 
		queue_free()
