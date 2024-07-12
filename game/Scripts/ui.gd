extends CanvasLayer

class_name UI

@onready var game_lost_container: CenterContainer = $GameLostContainer
@onready var lifes_label: Label = %LifesLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_lifes(lifes: int):
	lifes_label.text = "Lifes: %d" % lifes


func game_over():
	game_lost_container.show()

func _on_game_lost_button_pressed() -> void:
	get_tree().reload_current_scene()
