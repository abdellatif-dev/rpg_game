extends Area2D

var player = null

func can_see_player():
	return player != null

func _on_player_dection_zone_body_entered(body: Node) -> void:
	player = body


func _on_player_dection_zone_body_exited(body: Node) -> void:
	player =null
