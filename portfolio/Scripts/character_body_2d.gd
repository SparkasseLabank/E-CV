extends CharacterBody2D
@onready var _animated_sprite = $Sprite2D
@onready var _escape_menu = $"../Menu"
@onready var _text_menu = $"../TextMenu"
@onready var menu_opened = false
@onready var link_to_open = ""
@onready var link_openable = false
@onready var github_area = $"../detection areas/Github_area/detect_area"
@onready var github_logo = $"../detection areas/Github_area/Github"
@onready var linkedin_logo = $"../detection areas/linkedIn_area/Linkedin"
@onready var video_logo = $"../detection areas/video_area/Video"
@onready var button_list = [$"../Menu/Visual/status",$"../Menu/Visual/skills",$"../Menu/Visual/projects"]
@onready var _text_menu_list = [$"../TextMenu/status_text",$"../TextMenu/skills_text",$"../TextMenu/projects_text"]
@onready var selected_button_index = 0
@onready var selected_button = button_list[selected_button_index]
@onready var text_menu_opened = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("menu"):
		if text_menu_opened == false:
			if menu_opened == false:
				menu_opened = true
				_escape_menu.show()
			else:
				menu_opened = false
				_escape_menu.hide()
		else:
			text_menu_opened = false
			_text_menu.hide()
			_text_menu_list[selected_button_index].hide()
				
	if menu_opened == false:
		if Input.is_action_pressed("up"):
			move(0, -2)
			_animated_sprite.play("walk_up")
		elif Input.is_action_pressed("down"):
			move(0,2)
			_animated_sprite.play("walk_down")
		elif Input.is_action_pressed("left"):
			move(-2, 0)
			_animated_sprite.play("walk_left")
		elif Input.is_action_pressed("right"):
			move(2, 0)
			_animated_sprite.play("walk_right")
		else:
			_animated_sprite.stop()
		
		if Input.is_action_just_pressed("interact"):
			if link_openable:
				open_link(link_to_open)
				
	else:
		if text_menu_opened == false:
			selected_button.play("selected")
			selected_button.stop()
			
			if Input.is_action_just_pressed("up"):
				selected_button.play("default")
				selected_button.stop()
				selected_button_index -= 1
				if selected_button_index < 0:
					selected_button_index = button_list.size() - 1
				selected_button = button_list[selected_button_index]
			elif Input.is_action_just_pressed("down"):
				selected_button.play("default")
				selected_button.stop()
				selected_button_index += 1
				if selected_button_index >= button_list.size():
					selected_button_index = 0
				selected_button = button_list[selected_button_index]
			elif Input.is_action_just_pressed("interact"):
				open_text_menu(selected_button_index)
				text_menu_opened = true
		else:
			if Input.is_action_just_pressed("menu"):
				text_menu_opened = false
				
			
	
	move_and_slide()

func move(x: int, y: int) -> void:
	position.x += x
	position.y += y

func open_text_menu(index: int) -> void:
	_text_menu.show()
	_text_menu_list[index].show()
	pass

func open_link(link: String) -> void:
	if OS.has_feature('web'):
		JavaScriptBridge.eval("""
		window.open('"""+link+"""', '_blank').focus();
	""")
	else :
		OS.shell_open(link)

func _on_github_area_body_entered(body: Node2D) -> void:
	github_logo.modulate.a = 1
	link_to_open = "https://github.com/SparkasseLabank"
	link_openable = true

func _on_github_area_body_exited(body: Node2D) -> void:
	github_logo.modulate.a = 0.5
	link_openable = false
	link_to_open = ""


func _on_linked_in_area_body_entered(body: Node2D) -> void:
	linkedin_logo.modulate.a = 1
	link_to_open = "https://www.linkedin.com/in/scotty-pruvost-80610a353/"
	link_openable = true

func _on_linked_in_area_body_exited(body: Node2D) -> void:
	linkedin_logo.modulate.a = 0.5
	link_openable = false
	link_to_open = ""


func _on_video_area_body_entered(body: Node2D) -> void:
	video_logo.modulate.a = 1
	link_to_open = "https://www.linkedin.com/in/scotty-pruvost-80610a353/"
	link_openable = true


func _on_video_area_body_exited(body: Node2D) -> void:
	video_logo.modulate.a = 0.5
	link_openable = false
	link_to_open = ""
