extends Area2D

class_name DeathZone
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

signal life_lost
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
	var ball_count = get_tree().get_nodes_in_group("ball").size()
	if ball_count < 2:
		life_lost.emit()
