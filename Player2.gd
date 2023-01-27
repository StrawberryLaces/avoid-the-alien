extends Area2D

signal hit2

export var speed = 400.0
var screen_size = Vector2.ZERO

func _ready():
	hide()
	screen_size = get_viewport_rect().size
	

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move2_right"):
		direction.x += 1
	if Input.is_action_pressed("move2_left"):
		direction.x -= 1
	
	if Input.is_action_pressed("move2_down"):
		direction.y += 1
	if Input.is_action_pressed("move2_up"):
		direction.y -= 1
	
	if direction.length() > 0:
		direction = direction.normalized()
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += direction * speed * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false

func _on_Player2_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	emit_signal("hit2")
