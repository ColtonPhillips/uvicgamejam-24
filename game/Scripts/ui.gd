extends CanvasLayer

class_name UI
@onready var lifes_label: Label = %LifesLabel

@onready var game_lost_container = $GameLostContainer
#@onready var level_won_container = $LevelWonContainer
@onready var loss_reason: Label = %LossReason

func set_lifes(lifes: int):
	lifes_label.text = "LIVES  %d" % lifes

func game_over(reason: String):
	loss_reason.text = reason
	get_tree().paused = true
	game_lost_container.show()

func _on_game_lost_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func on_level_won():
	#level_won_container.show()
	get_tree().reload_current_scene()
	
func _on_level_won_button_pressed():
	#LevelDefinitions.current_level = 2
	get_tree().reload_current_scene()
