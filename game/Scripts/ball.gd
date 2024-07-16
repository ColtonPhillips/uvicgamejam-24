extends CharacterBody2D

class_name Ball

signal life_lost

const VELOCITY_LIMIT = 100

@export var ball_speed = 20
@export var lifes = 3
@export var death_zone: DeathZone
@export var ui: UI

var speed_up_factor := 1.01
var natural_speed_up := 0.001
var start_position: Vector2
var last_collider_id

@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	#ui.set_lifes(lifes)
	start_position = position
	death_zone.life_lost.connect(on_life_lost)

func _physics_process(delta):
	natural_speed_up += 0.005
	var collision = move_and_collide(velocity * (ball_speed + natural_speed_up) * delta)
	if (!collision):
		entered_paddle = false
		return
	
	
		
	var collider = collision.get_collider()
	if (collider is Brick):
		%HitSound.play()
		collider.decrease_level()		
		velocity = velocity.bounce(collision.get_normal())
		velocity = velocity.rotated(randf_range(-0.2, 0.2))
		
	elif (collider is Wall):
		%ClickSound.play()		
		velocity = velocity.bounce(collision.get_normal())
		if abs(velocity.y) < 4 or abs(velocity.x) < 4:
			velocity = velocity.rotated(randf_range(-0.6, 0.6))
			#print (velocity)
	if ( collider is Paddle):
		paddle_collision(collider)
	
	
func start_ball():
	position = start_position
	position.x = $"../Paddle".position.x
	natural_speed_up = 0
	randomize()
	
	velocity = Vector2(randf_range(-0.2, 0.2), randf_range(-.1, -1)).normalized() * ball_speed

func on_life_lost():
	lifes -= 1
	if lifes == 0:
		ui.game_over("YOU RAN OUT OF LIVES!")
	else:
		life_lost.emit()
		reset_ball()
		ui.set_lifes(lifes)

func reset_ball():
	position = start_position
	position.x = $"../Paddle".position.x

	velocity = Vector2.ZERO

var entered_paddle = false;
func paddle_collision(collider):
	%PopSound.play()
	collider.squee()

	var ball_width = collision_shape_2d.shape.get_rect().size.x
	var ball_center_x = position.x
	var collider_width = collider.get_width()
	var collider_center_x = collider.position.x
	var velocity_xy = velocity.length()
	var collision_x = (ball_center_x - collider_center_x) / (collider_width / 2)
	var new_velocity = Vector2.ZERO
	
	
	new_velocity.x = velocity_xy * collision_x
	#new_velocity.y = sqrt(absf(velocity_xy* velocity_xy - new_velocity.x * new_velocity.x)) * (-1 if velocity.y > 0 else 1)
	new_velocity.y = velocity_xy * 2 * (-1 if velocity.y > 0 else 1)

	new_velocity = new_velocity.normalized() * velocity_xy
	if entered_paddle == false:
		new_velocity *= speed_up_factor
		entered_paddle = true
	velocity = (new_velocity).limit_length(VELOCITY_LIMIT)
	if velocity.y > 0: velocity.y *= -1
