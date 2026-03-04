extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("up"):
		move(0, -1)
	if Input.is_action_pressed("down"):
		move(0,1)
	if Input.is_action_pressed("left"):
		move(-1, 0)
	if Input.is_action_pressed("right"):
		move(1, 0)
	
	move_and_slide()

func move(x: int, y: int) -> void:
	position.x += x
	position.y += y
