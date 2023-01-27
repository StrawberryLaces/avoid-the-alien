extends KinematicBody2D

var speed = 200
var motion


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_input():
	look_at(get_global_mouse_position())
	
func _physics_process(delta):
	get_input()
	if Input.is_action_pressed("down"):
		motion.y = speed.rotated(rotation)
	elif Input.is_action_pressed("up"):
		motion.y = speed.rotated(rotation)
	else:
		motion.y = 0
		motion.x = 0
	
	#velocity = move_and_slide(velocity)
	
	move_and_slide(motion, Vector2(0, 0), false, 4, 0.785, false)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
