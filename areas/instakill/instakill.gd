extends Area2D

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Player) -> void:
	if body is Player:
		body.insta_kill()
