extends KinematicBody2D

var health = 160

func _process(delta):
	Global.enemy = self
	if health <= 0:
		queue_free()
	$HUD/Health.text = str(health)
