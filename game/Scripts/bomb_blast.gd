extends Area2D

class_name BombBlast

func delete_me_from_this_conversation():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate", Color(0,0,0,0), 0.2)
	monitoring = false
	await get_tree().create_timer(0.25).timeout
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Brick:
		body.decrease_level()
		delete_me_from_this_conversation()
