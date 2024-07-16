extends CanvasLayer

class_name UI
@onready var lifes_label: Label = %LifesLabel

@onready var game_lost_container = $GameLostContainer
#@onready var level_won_container = $LevelWonContainer
@onready var loss_reason: Label = %LossReason
@onready var death_sound: AudioStreamPlayer = $DeathSound
@onready var level_won_container: CenterContainer = $LevelWonContainer

func _ready():
	set_lifes(LevelDefinitions.lives)

func set_lifes(lifes: int):
	lifes_label.text = "LIVES  %d" % lifes

func game_over(reason: String):
	set_lifes(0)
	death_sound.play()
	loss_reason.text = reason
	get_tree().paused = true
	LevelDefinitions.current_level = 1
	game_lost_container.show()

func _on_game_lost_button_pressed():
	get_tree().paused = false
	LevelDefinitions.reset_game()
	get_tree().reload_current_scene()

func on_level_won():
	if LevelDefinitions.is_last_level():
		game_over("YOU WON THE GAME. PLAY AGAIN?")
	else:	
		level_won_container.show()
		LevelDefinitions.current_level += 1
		get_tree().paused = true
	
	#get_tree().reload_current_scene()
	
func _on_level_won_button_pressed():
	#LevelDefinitions.current_level = 2
	get_tree().paused = false
	
	get_tree().reload_current_scene()
