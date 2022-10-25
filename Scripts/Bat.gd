extends KinematicBody2D

var health = 160
var player = null
var move = Vector2.ZERO
var speed = 1

func move_to_player():
	move = Vector2.ZERO
	
	if player != null:
		move = position.direction_to(player.position) * speed
		
	else:
		move = Vector2.ZERO
		
	move = move.normalized()
	move = move_and_collide(move)

func _process(delta):
	if health <= 0:
		queue_free()
	move_to_player()

func _on_Playerchecker_body_entered(body):
	if body.is_in_group("Player"):
		if body != self:
			player = body

func _on_Playerchecker_body_exited(body):
	player = null
