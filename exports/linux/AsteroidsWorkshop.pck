GDPC                 �                                                                      )   \   res://.godot/exported/133200997/export-30982c1461f8c406e814052458a11f62-Medium_Asteroid.scn p"      U      +�����w7��X�	    T   res://.godot/exported/133200997/export-5c1d4b55b08ed337930cbba8372cde12-Bullet.scn  0      G      �@�kT�z��(4W�t�    \   res://.godot/exported/133200997/export-7c0f746f7e97d49a9851c833a9a12b21-Large_Asteroid.scn         �      �XE��e�C�o>��    T   res://.godot/exported/133200997/export-81ac81193aa819dc19769e88ef012874-Player.scn  0-      i      ��wOwͅ�IrCw�o    \   res://.godot/exported/133200997/export-8d65aeb21692809ad20517596250f782-Small_Asteroid.scn  �5      I      �#w���xN��#�'    P   res://.godot/exported/133200997/export-c3a18e22562729dd767fe86faf14d28e-Game.scn            ]0
�RF_ko�$.�-&    P   res://.godot/exported/133200997/export-daf010845257121816365d93c5fd8bc3-UI.scn  �K            ��ׄi��H
km8��    X   res://.godot/exported/133200997/export-df45cd4064099af92dd311cb1cf2b68c-Start_Screen.scn`<      /      ng�^^���l(F|��.    ,   res://.godot/global_script_class_cache.cfg   u             ��Р�8���8~$}P�    T   res://.godot/imported/Big_Asteroid-1.png.png-670d07c68b941b60320c8b7d41f9b6f0.ctex   X      d      ����#L�N�4%J2ҚA    L   res://.godot/imported/Bullet-1.png.png-fb6964730466bff0850262e2b083530c.ctex@[      �       Z�w;����)�l    X   res://.godot/imported/Medium_Asteroid-2.png.png-02b76427ec31ec0a5a1b90ba09ce1aa0.ctex   �\      �      &�* �`R���a6��    L   res://.godot/imported/Player-1.png.png-d54086c10c1fd3ee5a146492c1989519.ctexp_      �      [�*���NR�����9    T   res://.godot/imported/Small_Asteroid-3.png.png-d37fd4d62248d0df99c413bcd7acedee.ctex b      �       ]��~�17}�jΌ�]Q�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex d      �      �Yz=������������       res://.godot/uid_cache.bin   y      �      �qF���k�]	Sa�Z        res://Global Scripts/Globals.gd               .�$݇R]�6�I��K�        res://Scenes/Bullet/Bullet.gd   �      �      ���{��~ޟm�    (   res://Scenes/Bullet/Bullet.tscn.remap   �q      c       CNdU�A�]9�(g       res://Scenes/Game/Game.gd   �	      �      5�Ǝ�n\�W T�Q�    $   res://Scenes/Game/Game.tscn.remap    r      a       ��Ql��b}�ݠ�D    0   res://Scenes/Large_Asteroid/Large_Asteroid.gd   0      �      ͆�����Pϣ[$	T    8   res://Scenes/Large_Asteroid/Large_Asteroid.tscn.remap   �r      k       ���� �����@ҧY�    0   res://Scenes/Medium_Asteroid/Medium_Asteroid.gd �      �      ���	�f�A�̛.5ټ    8   res://Scenes/Medium_Asteroid/Medium_Asteroid.tscn.remap  s      l       �����Cp��΀        res://Scenes/Player/Player.gd   �&      _      X�@�ed�zc�l���O    (   res://Scenes/Player/Player.tscn.remap   ps      c       2rW��M�8��1��A    0   res://Scenes/Small_Asteroid/Small_Asteroid.gd   �2      <      ��37s�v	���G�։�    8   res://Scenes/Small_Asteroid/Small_Asteroid.tscn.remap   �s      k       b�jԖыJ����( �    ,   res://Scenes/Start_Screen/Start_Screen.gd   0:      '      �`I���5�ga�؏x-    4   res://Scenes/Start_Screen/Start_Screen.tscn.remap   Pt      i       e։�o� �+zy�E$�|       res://Scenes/UI/UI.gd   �D      A      �ЙS}f
����T��        res://Scenes/UI/UI.tscn.remap   �t      _       ��ս����x�]��    ,   res://Sprites/Big_Asteroid-1.png.png.import pZ      �       �(n��W���R�    (   res://Sprites/Bullet-1.png.png.import   �[      �       ��Jn���bV���N�    0   res://Sprites/Medium_Asteroid-2.png.png.import  �^      �       ��cY�����5(왺    (   res://Sprites/Player-1.png.png.import   Pa      �       �y�Ib7	~k�<���    0   res://Sprites/Small_Asteroid-3.png.png.import    c      �       ;�S͇��;���       res://icon.svg  @u      �      C��=U���^Qu��U3       res://icon.svg.import   �p      �       @�Q��81H�xG0���       res://project.binary�{      �      �M��'Y}�	J���        extends Node

var score: int
var lives = 3
var high_score = 0

signal increase_score(value)
signal take_damage(player)


func _ready():
	high_score = load_high_score()


func _process(_delta):
	pass


func reset_variables():
	score = 0
	lives = 3


func save_high_score():
	var saved_score = FileAccess.open("user://high_score.save", FileAccess.WRITE)
	var save_text = JSON.stringify({"High Score": Globals.high_score})
	saved_score.store_line(save_text)


func load_high_score():
	if not FileAccess.file_exists("user://high_score.save"):
		print_debug("File does not exist")
		return 0
	var saved_score = FileAccess.open("user://high_score.save", FileAccess.READ)
	var json_string = saved_score.get_line()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print_debug("No JSON")
		return 0
	var data = json.get_data()
	return data["High Score"]
 extends Area2D

var direction: Vector2
var bullet_speed = 700
var screen_size


func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	position += direction * bullet_speed * delta
	if position.x < 0:
		queue_free()
	if position.x > screen_size.x:
		queue_free()
	if position.y < 0:
		queue_free()
	if position.y > screen_size.y:
		queue_free()


func _on_area_entered(area):
	area.destroy()
	queue_free()
  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    script 	   _bundled       Script    res://Scenes/Bullet/Bullet.gd ��������
   Texture2D    res://Sprites/Bullet-1.png.png �-���l�%      local://CircleShape2D_rm6av �         local://PackedScene_7k44s �         CircleShape2D             A         PackedScene          	         names "         Bullet    collision_layer    collision_mask    script    Area2D 	   Sprite2D    texture    CollisionShape2D    shape    _on_area_entered    area_entered    	   variants                                                      node_count             nodes        ��������       ����                                        ����                           ����                   conn_count             conns                
   	                    node_paths              editable_instances              version             RSRC         extends Node2D

@onready var spawn_timer = $Spawn_Timer

var screen_size
var asteroid_scenes = {
	0: preload("res://Scenes/Large_Asteroid/Large_Asteroid.tscn"),
	1: preload("res://Scenes/Medium_Asteroid/Medium_Asteroid.tscn"),
	2: preload("res://Scenes/Small_Asteroid/Small_Asteroid.tscn")
}


func _ready():
	screen_size = get_viewport().get_visible_rect().size


func _process(_delta):
	pass


func spawn_asteroid():
	var new_asteroid = asteroid_scenes[randi_range(0,2)].instantiate()
	add_child(new_asteroid)
	new_asteroid.global_position = generate_spawn_point()


func random_vector(left, right, bottom, top):
	return Vector2(randf_range(left, right), randf_range(bottom, top))

func generate_spawn_point():
	var locations = [
		# Upper Rectangle
		random_vector(0, screen_size.x, screen_size.y, screen_size.y),
		# Lower Rectangle
		random_vector(0, screen_size.x, -screen_size.y, -screen_size.y),
		# Right Rectangle
		random_vector(screen_size.x, screen_size.x, 0, screen_size.y),
		# Left Rectangle
		random_vector(-screen_size.x, -screen_size.x, 0, screen_size.y),
	]
	return locations[randi_range(0,3)]


func _on_spawn_timer_timeout():
	spawn_asteroid()
  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Scenes/Game/Game.gd ��������   PackedScene     res://Scenes/Player/Player.tscn �'?���Z   PackedScene    res://Scenes/UI/UI.tscn ?z'*���{      local://PackedScene_4p5tt �         PackedScene          	         names "         Game    script    Node2D    Player 	   position    Spawn_Timer 
   wait_time 
   autostart    Timer    UI    _on_spawn_timer_timeout    timeout    	   variants                          
     pD  D      @                     node_count             nodes     $   ��������       ����                      ���                                 ����                           ���	                    conn_count             conns                  
                    node_paths              editable_instances              version             RSRC    extends Area2D

const MEDIUM_ASTEROID = preload("res://Scenes/Medium_Asteroid/Medium_Asteroid.tscn")
var screen_size
var speed
var rotation_speed
var direction


func _ready():
	screen_size = get_viewport_rect().size
	set_direction_and_speed()


func _process(delta):
	# Screen Wrap
	if position.x < 0:
		position.x = screen_size.x
	if position.x > screen_size.x:
		position.x = 0
	if position.y < 0:
		position.y = screen_size.y
	if position.y > screen_size.y:
		position.y = 0

	# Moving 
	position += direction * speed * delta
	rotation += rotation_speed * delta


func set_direction_and_speed():
	var angle = randf_range(0, 2 * PI)  # Random angle in radians
	direction = Vector2(cos(angle), sin(angle))  # Convert angle to direction vector
	speed = randf_range(75, 200)  # Random speed between 75 and 200
	rotation_speed = randf_range(-1, 1)


func destroy():
	Globals.increase_score.emit(100)
	call_deferred("create_and_add_asteroids")


func create_and_add_asteroids():
	# Instantate two small asteroids
	var medium_asteroid1 = MEDIUM_ASTEROID.instantiate()
	var medium_asteroid2 = MEDIUM_ASTEROID.instantiate()

	# Set their positions to the position of the medium asteroid
	medium_asteroid1.position = self.position
	medium_asteroid2.position = self.position

	# Add them as children of the medium asteroid's parent
	self.get_parent().add_child(medium_asteroid1)
	self.get_parent().add_child(medium_asteroid2)

	# Queue the medium asteroid for deletion
	self.queue_free()
       RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script .   res://Scenes/Large_Asteroid/Large_Asteroid.gd ��������
   Texture2D %   res://Sprites/Big_Asteroid-1.png.png ��|(      local://PackedScene_6lo5q d         PackedScene          	         names "   	      Large_Asteroid    collision_layer    collision_mask    script    Area2D 	   Sprite2D    texture    CollisionPolygon2D    polygon    	   variants                                       %            X�  ��  h�  ��  `�  ��  8�  �  (�  0�  �  H�  ��  l�  �  t�  �@  `�  �A  <�  �A  8�  $B  $�  @B  �  LB  ��  dB  ��  XB  ��  PB      HB   A  XB  �A  XB  ,B  <B  XB  4B  pB  B  pB  �A  \B  pA  `B  @@  TB  ��  \B  ��  XB  ��  B  T�  `A  d�      node_count             nodes        ��������       ����                                        ����                           ����                   conn_count              conns               node_paths              editable_instances              version             RSRC         extends Area2D

const SMALL_ASTEROID = preload("res://Scenes/Small_Asteroid/Small_Asteroid.tscn")
var screen_size
var speed
var rotation_speed
var direction


func _ready():
	screen_size = get_viewport_rect().size
	set_direction_and_speed()


func _process(delta):
	# Screen Wrap
	if position.x < 0:
		position.x = screen_size.x
	if position.x > screen_size.x:
		position.x = 0
	if position.y < 0:
		position.y = screen_size.y
	if position.y > screen_size.y:
		position.y = 0

	# Moving 
	position += direction * speed * delta
	rotation += rotation_speed * delta


func set_direction_and_speed():
	var angle = randf_range(0, 2 * PI)  # Random angle in radians
	direction = Vector2(cos(angle), sin(angle))  # Convert angle to direction vector
	speed = randf_range(75, 200)  # Random speed between 75 and 200
	rotation_speed = randf_range(-1, 1)


func destroy():
	Globals.increase_score.emit(200)
	call_deferred("create_and_add_asteroids")


func create_and_add_asteroids():
	# Instantate two small asteroids
	var small_asteroid1 = SMALL_ASTEROID.instantiate()
	var small_asteroid2 = SMALL_ASTEROID.instantiate()

	# Set their positions to the position of the medium asteroid
	small_asteroid1.position = self.position
	small_asteroid2.position = self.position

	# Add them as children of the medium asteroid's parent
	self.get_parent().add_child(small_asteroid1)
	self.get_parent().add_child(small_asteroid2)

	# Queue the medium asteroid for deletion
	self.queue_free()
  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script 0   res://Scenes/Medium_Asteroid/Medium_Asteroid.gd ��������
   Texture2D (   res://Sprites/Medium_Asteroid-2.png.png ΡG�*�
w      local://PackedScene_06uvq i         PackedScene          	         names "   	      Medium_Asteroid    collision_layer    collision_mask    script    Area2D 	   Sprite2D    texture    CollisionPolygon2D    polygon    	   variants                                       %        �@  $�  0�  �  ��  ��  ��  ��  ��  ��  ��  ��  �   A  �  pA  ��  �A  �  �A  ��  �A  �@  B  `A  B  �A  B  B  �A  B  �@  (B   �  (B  ��  �A  ��  pA   �      node_count             nodes        ��������       ����                                        ����                           ����                   conn_count              conns               node_paths              editable_instances              version             RSRC           extends CharacterBody2D

@onready var shoot_timer = $ShootTimer

const BULLET = preload("res://Scenes/Bullet/Bullet.tscn")
var screen_size
var thrust = 500
var maxSpeed = 10
var rotateSpeed = 5
var slowDown = 1
var immune = true


func _ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	if position.x < 0:
		position.x = screen_size.x
	if position.x > screen_size.x:
		position.x = 0
	if position.y < 0:
		position.y = screen_size.y
	if position.y > screen_size.y:
		position.y = 0
		
	if Input.is_action_pressed("rotate_left"):
		rotation += -1 * rotateSpeed * delta
	if Input.is_action_pressed("rotate_right"):
		rotation += 1 * rotateSpeed * delta
	if Input.is_action_pressed("thrust"):
		velocity += ((Vector2(0, -1) * thrust * delta).rotated(rotation))
		immune = false
	else:
		velocity = lerp(velocity, Vector2.ZERO, slowDown * delta)
		if velocity.y >= -1 && velocity.y <= 1:
			velocity.y = 0
			
	move_and_collide(velocity * delta)
	
	if Input.is_action_pressed("shoot") && shoot_timer.time_left == 0 && immune == false:  # Use action_just_pressed to prevent multiple bullets on a single press
		var bulletInstance = BULLET.instantiate()  # Create a new instance of the Bullet scene
		get_parent().add_child(bulletInstance)  # Add it to the player node or a designated parent node for bullets
		bulletInstance.global_position = global_position  # Set the bullet's position
		bulletInstance.direction = Vector2.UP.rotated(rotation)  # Set the bullet's direction
		shoot_timer.start(0.35)


func _on_area_2d_area_entered(_area):
	if !immune:
		Globals.take_damage.emit(self)
		immune = true
 RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Scenes/Player/Player.gd ��������
   Texture2D    res://Sprites/Player-1.png.png ��(s�fZ      local://PackedScene_4h1j3 N         PackedScene          	         names "         Player    scale    collision_mask    script    metadata/_edit_group_    CharacterBody2D 	   Sprite2D    texture    CollisionPolygon2D 	   position    build_mode    polygon    ShootTimer 
   wait_time 	   one_shot 
   autostart    Timer    Area2D    _on_area_2d_area_entered    area_entered    	   variants    
   
     �>33�>                               
       '���
     �?�Mo?      %          �*p�  �� ��B    ��*B  �B ��B)   ffffff�?      node_count             nodes     L   ��������       ����                                              ����                           ����   	            
                              ����      	                                 ����                          ����   	            
                      conn_count             conns                                      node_paths              editable_instances              version             RSRC       extends Area2D

var screen_size
var speed
var rotation_speed
var direction


func _ready():
	screen_size = get_viewport_rect().size
	set_direction_and_speed()


func _process(delta):
	# Screen Wrap
	if position.x < 0:
		position.x = screen_size.x
	if position.x > screen_size.x:
		position.x = 0
	if position.y < 0:
		position.y = screen_size.y
	if position.y > screen_size.y:
		position.y = 0

	# Moving 
	position += direction * speed * delta
	rotation += rotation_speed * delta


func set_direction_and_speed():
	var angle = randf_range(0, 2 * PI)  # Random angle in radians
	direction = Vector2(cos(angle), sin(angle))  # Convert angle to direction vector
	speed = randf_range(75, 200)  # Random speed between 75 and 200
	rotation_speed = randf_range(-1, 1)


func destroy():
	Globals.increase_score.emit(300)
	queue_free()
    RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script .   res://Scenes/Small_Asteroid/Small_Asteroid.gd ��������
   Texture2D '   res://Sprites/Small_Asteroid-3.png.png ,P�Y9      local://PackedScene_mwmja f         PackedScene          	         names "   	      Small_Asteroid    collision_layer    collision_mask    script    Area2D 	   Sprite2D    texture    CollisionPolygon2D    polygon    	   variants                                       %        @�   �   �   �  ��   �  �  ��  ��   �  ��   @  ��  �@  ��   A  @@   A  @@  0A  0A  0A  �A  �@  �A      �A  0�  `A  P�   A  ��  �?  ��  ��  ��  @�  ��      node_count             nodes        ��������       ����                                        ����                           ����                   conn_count              conns               node_paths              editable_instances              version             RSRC       extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/High_Score_Label.text = "High Score: " + str(Globals.high_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")


func _on_start_game_pressed():
	Globals.reset_variables()
	get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")


func _on_exit_pressed():
	get_tree().quit()
         RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script *   res://Scenes/Start_Screen/Start_Screen.gd ��������      local://PackedScene_grnei !         PackedScene          	         names "         Start_Screen    script    Node2D    Control    layout_mode    anchors_preset    offset_right    offset_bottom    Start_Game    anchor_left    anchor_top    anchor_right    anchor_bottom    offset_left    offset_top    grow_horizontal    grow_vertical $   theme_override_font_sizes/font_size    text    Button    Exit    Title    Label    High_Score_Label    horizontal_alignment    vertical_alignment    _on_start_game_pressed    pressed    _on_exit_pressed    	   variants    "                               �D     �D                  ?     D�     x�     DB     xA         d         Start Game      ��     �B     �B    @�C      Exit     �*�    @��    �*D     ��   ,     
   Asteroids            �?     ��     �     �B     ��             High Score:       node_count             nodes     �   ��������       ����                            ����                                            ����               	      
                           	      
                                                  ����               	      
                                                                                   ����               	      
                                                                                   ����               	      
                                                                !                         conn_count             conns                                                              node_paths              editable_instances              version             RSRC extends CanvasLayer

var screen_size


func _ready():
	Globals.connect("increase_score", update_score)
	Globals.connect("take_damage", update_lives)
	screen_size = get_viewport().get_visible_rect().size


func _process(_delta):
	if Input.is_action_just_pressed("Escape"):
		toggle_pause_menu()
	if $Restart_Button.visible == true && Input.is_action_just_pressed("shoot"):
		restart()


func update_score(value):
	Globals.score += value
	$Score_Label.text = "Score: " + str(Globals.score)


func update_lives(player):
	Globals.lives -= 1
	if Globals.lives == 2:
		$Life3_Texture.visible = false
		player.position = Vector2(960,540)
		player.velocity = Vector2(0,0)
		player.rotation = 0
	elif Globals.lives == 1:
		player.position = Vector2(960,540)
		player.velocity = Vector2(0,0)
		player.rotation = 0
		$Life2_Texture.visible = false
	elif Globals.lives == 0:
		game_over()
		player.queue_free()
		$Life1_Texture.visible = false


func game_over():
	if Globals.score > Globals.high_score:
		Globals.high_score = Globals.score
		$High_Score_Label.text = "New High Score: " + str(Globals.high_score)
		Globals.save_high_score()
	else: $High_Score_Label.text = "High Score: " + str(Globals.high_score)
	$Score_Label.set("theme_override_font_sizes/font_size", 56)
	$Score_Label.position.y = screen_size.y/2 - 45
	$High_Score_Label.visible = true
	$Restart_Button.visible = true


func toggle_pause_menu():
	get_tree().paused = not get_tree().paused
	$Pause_Menu.visible = !$Pause_Menu.visible


func restart():
	if get_tree().paused:
		toggle_pause_menu()
	get_tree().reload_current_scene()
	Globals.reset_variables()


func _on_restart_button_pressed():
	restart()


func _on_resume_button_pressed():
	toggle_pause_menu()


func _on_exit_button_pressed():
	toggle_pause_menu()
	get_tree().change_scene_to_file("res://Scenes/Start_Screen/Start_Screen.tscn")
               RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Scenes/UI/UI.gd ��������
   Texture2D    res://Sprites/Player-1.png.png ��(s�fZ      local://PackedScene_v7gsy F         PackedScene          	         names "   +      UI    process_mode    script    CanvasLayer    Score_Label    anchors_preset    anchor_left    anchor_right    offset_left    offset_right    offset_bottom    grow_horizontal $   theme_override_font_sizes/font_size    text    Label    Lives_Text_Label    horizontal_alignment    vertical_alignment    Life1_Texture    offset_top    texture    expand_mode    TextureRect    Life2_Texture    Life3_Texture    High_Score_Label    visible    Restart_Button    grow_vertical    Button    Pause_Menu    layout_mode    anchor_bottom    Control    Dim_Overlay    color 
   ColorRect    Exit_Button    Resume_Button    _on_restart_button_pressed    pressed    _on_exit_button_pressed    _on_resume_button_pressed    	   variants    4                               ?     ��     �A     �A                	   Score: 0      �B     4B      Lives:             �B     �@     �B      B              C      C     *C     CC            .�     .B   �         High Score:     `D    �"D    СD    �FD   d         Restart Game            �?               ���>    `cD     D    �|D     *D   4         Exit     �UD     �C    �D     �C      Resume     @DD     �C    ��D     D      node_count             nodes       ��������       ����                                  ����	                           	      
                     	                     ����   	   
   
                                                ����               	      
                                    ����               	      
                                    ����               	      
                                    ����                                 	      
                                                      ����	                     	      
                            !               !      ����                   "      #       #                          $   "   ����            "      #       #               #   $                 %   ����	            %      &   	   '   
   (                  )      *                 &   ����	            +      ,   	   -   
   .                  )      /                    ����	            0      1   	   2   
   3                  )      !             conn_count             conns               (   '              
       (   )                     (   *                     (   '                    node_paths              editable_instances              version             RSRC             GST2   �   �      ����               � �        ,  RIFF$  WEBPVP8L  /�0��?��pʵmű�� �pX���*0A��Mѽ�o@D�'@?'oo8	�D�����y��V��]^������<� a����M�n������N�)/��k�$%�~h���Z���[���D�/$h����q�,u���d���L�O�~'�(��^�Q�~GPp�� �����Lt��:x�':h��Pp�p�N*�H��':�	�"%�����U�D{��;�O�y�AzE2IP�2�)w���I������J0�Q�i(w�����W�	�"��U��:���d�%>�}Q��@�f��gT��jv|Y�i(��p&.u��=�B���Q�T�Q3��A0h�^Ή�2�D�˃f�:�&�#�nF1J_�������l�$���A��I@��	��@'H��^Z��V�����B$�#�/�IJ4@R��_. ����K�p3�����
/e���}�
x��A���_�F������#4x
���7�e�]���e"x
�fN뉷�4	:!����            [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://diia43eytv2d"
path="res://.godot/imported/Big_Asteroid-1.png.png-670d07c68b941b60320c8b7d41f9b6f0.ctex"
metadata={
"vram_texture": false
}
   GST2   �   �      ����               � �        v   RIFFn   WEBPVP8Lb   /�0��?��pF�m7�J��H��P$�O$ОͿz�3����gu � $���Ԋg�Ӑ�D�J.����n%M"�$Dg�4 P+���ɤ�4�  [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bexsw2yj0jinr"
path="res://.godot/imported/Bullet-1.png.png-fb6964730466bff0850262e2b083530c.ctex"
metadata={
"vram_texture": false
}
        GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /�0��?��p��m�m>��~P�?�Z��;X�&H�)����O���͌
�ѯ%�̩[���;����d#:M��� �K��Jr�ԣ6 H��C�@$��C�A��C*�CW���$��1t�F<�tpЉ��Q��h)h��̅d�h��`j���B#�>1\lm.Ӊ�[�*j��.&.ĹL��%��-eYE�����責�L�UɄ)Z�b��tM�3�=.��2%�� ��㐖�e�.���7C߮�����E(/�-�F�+��K�LU�:���	.�'ct˰����>0!F����&K��qn�O��&�]!z�	yx��}�}���<�Sq�
�r�$L�s=K^H��A�   [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://duhf8daiqg8ik"
path="res://.godot/imported/Medium_Asteroid-2.png.png-02b76427ec31ec0a5a1b90ba09ce1aa0.ctex"
metadata={
"vram_texture": false
}
               GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /�0��?��pؑ$Kq�e���&�>0�	{�|��tID�_�۶�:|�C�����2篋���5�5^����=>x��}����<f��S<f�Y�c�A�u�x�:S<b�)���X���V�x��)�oe��[�⹖�x��(�k)��Z��y��x��)�gi��Y�s���9VE���x�UR�ڪ)^m���j�W[ū,��U�C�*ˡx�eQ<myO[�ӖG�eR<e�OY.�S�K�eS�l�/[>�3��T���jk�huJ�>��*vM���S����\��ԑ�i:F7�Ӥg��b�#:�bϣ�=�yD�Ql9�1ҫ&������H��T���D��V���:��Zo"ĚM�9s���|���rKkϲ��g���Ϛ�y�l               [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cy2p3man040cg"
path="res://.godot/imported/Player-1.png.png-d54086c10c1fd3ee5a146492c1989519.ctex"
metadata={
"vram_texture": false
}
        GST2   �   �      ����               � �        �   RIFF�   WEBPVP8L�   /�0��?��pȭm���K`?,�����ޱ���f�ჷ3@D�'@l�y*@��9z���xN��C�����8���.�
철���1�YZ:/�h$ieI2E�T�G/;��Sw$´�\@���z+&��d`�������f��f�*�Y�Wo����T��         [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://by42ob5hwsx85"
path="res://.godot/imported/Small_Asteroid-3.png.png-d37fd4d62248d0df99c413bcd7acedee.ctex"
metadata={
"vram_texture": false
}
                GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح����mow�*��f�&��Cp�ȑD_��ٮ}�)� C+���UE��tlp�V/<p��ҕ�ig���E�W�����Sթ�� ӗ�A~@2�E�G"���~ ��5tQ#�+�@.ݡ�i۳�3�5�l��^c��=�x�Н&rA��a�lN��TgK㼧�)݉J�N���I�9��R���$`��[���=i�QgK�4c��%�*�D#I-�<�)&a��J�� ���d+�-Ֆ
��Ζ���Ut��(Q�h:�K��xZ�-��b��ٞ%+�]�p�yFV�F'����kd�^���:[Z��/��ʡy�����EJo�񷰼s�ɿ�A���N�O��Y��D��8�c)���TZ6�7m�A��\oE�hZ�{YJ�)u\a{W��>�?�]���+T�<o�{dU�`��5�Hf1�ۗ�j�b�2�,%85�G.�A�J�"���i��e)!	�Z؊U�u�X��j�c�_�r�`֩A�O��X5��F+YNL��A��ƩƗp��ױب���>J�[a|	�J��;�ʴb���F�^�PT�s�)+Xe)qL^wS�`�)%��9�x��bZ��y
Y4�F����$G�$�Rz����[���lu�ie)qN��K�<)�:�,�=�ۼ�R����x��5�'+X�OV�<���F[�g=w[-�A�����v����$+��Ҳ�i����*���	�e͙�Y���:5FM{6�����d)锵Z�*ʹ�v�U+�9�\���������P�e-��Eb)j�y��RwJ�6��Mrd\�pyYJ���t�mMO�'a8�R4��̍ﾒX��R�Vsb|q�id)	�ݛ��GR��$p�����Y��$r�J��^hi�̃�ūu'2+��s�rp�&��U��Pf��+�7�:w��|��EUe�`����$G�C�q�ō&1ŎG�s� Dq�Q�{�p��x���|��S%��<
\�n���9�X�_�y���6]���մ�Ŝt�q�<�RW����A �y��ػ����������p�7�l���?�:������*.ո;i��5�	 Ύ�ș`D*�JZA����V^���%�~������1�#�a'a*�;Qa�y�b��[��'[�"a���H�$��4� ���	j�ô7�xS�@�W�@ ��DF"���X����4g��'4��F�@ ����ܿ� ���e�~�U�T#�x��)vr#�Q��?���2��]i�{8>9^[�� �4�2{�F'&����|���|�.�?��Ȩ"�� 3Tp��93/Dp>ϙ�@�B�\���E��#��YA 7 `�2"���%�c�YM: ��S���"�+ P�9=+D�%�i �3� �G�vs�D ?&"� !�3nEФ��?Q��@D �Z4�]�~D �������6�	q�\.[[7����!��P�=��J��H�*]_��q�s��s��V�=w�� ��9wr��(Z����)'�IH����t�'0��y�luG�9@��UDV�W ��0ݙe)i e��.�� ����<����	�}m֛�������L ,6�  �x����~Tg����&c�U��` ���iڛu����<���?" �-��s[�!}����W�_�J���f����+^*����n�;�SSyp��c��6��e�G���;3Z�A�3�t��i�9b�Pg�����^����t����x��)O��Q�My95�G���;w9�n��$�z[������<w�#�)+��"������" U~}����O��[��|��]q;�lzt�;��Ȱ:��7�������E��*��oh�z���N<_�>���>>��|O�׷_L��/������զ9̳���{���z~����Ŀ?� �.݌��?�N����|��ZgO�o�����9��!�
Ƽ�}S߫˓���:����q�;i��i�]�t� G��Q0�_î!�w��?-��0_�|��nk�S�0l�>=]�e9�G��v��J[=Y9b�3�mE�X�X�-A��fV�2K�jS0"��2!��7��؀�3���3�\�+2�Z`��T	�hI-��N�2���A��M�@�jl����	���5�a�Y�6-o���������x}�}t��Zgs>1)���mQ?����vbZR����m���C��C�{�3o��=}b"/�|���o��?_^�_�+��,���5�U��� 4��]>	@Cl5���w��_$�c��V��sr*5 5��I��9��
�hJV�!�jk�A�=ٞ7���9<T�gť�o�٣����������l��Y�:���}�G�R}Ο����������r!Nϊ�C�;m7�dg����Ez���S%��8��)2Kͪ�6̰�5�/Ӥ�ag�1���,9Pu�]o�Q��{��;�J?<�Yo^_��~��.�>�����]����>߿Y�_�,�U_��o�~��[?n�=��Wg����>���������}y��N�m	n���Kro�䨯rJ���.u�e���-K��䐖��Y�['��N��p������r�Εܪ�x]���j1=^�wʩ4�,���!�&;ج��j�e��EcL���b�_��E�ϕ�u�$�Y��Lj��*���٢Z�y�F��m�p�
�Rw�����,Y�/q��h�M!���,V� �g��Y�J��
.��e�h#�m�d���Y�h�������k�c�q��ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[          [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cp86p70hx5vkx"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                [remap]

path="res://.godot/exported/133200997/export-5c1d4b55b08ed337930cbba8372cde12-Bullet.scn"
             [remap]

path="res://.godot/exported/133200997/export-c3a18e22562729dd767fe86faf14d28e-Game.scn"
               [remap]

path="res://.godot/exported/133200997/export-7c0f746f7e97d49a9851c833a9a12b21-Large_Asteroid.scn"
     [remap]

path="res://.godot/exported/133200997/export-30982c1461f8c406e814052458a11f62-Medium_Asteroid.scn"
    [remap]

path="res://.godot/exported/133200997/export-81ac81193aa819dc19769e88ef012874-Player.scn"
             [remap]

path="res://.godot/exported/133200997/export-8d65aeb21692809ad20517596250f782-Small_Asteroid.scn"
     [remap]

path="res://.godot/exported/133200997/export-df45cd4064099af92dd311cb1cf2b68c-Start_Screen.scn"
       [remap]

path="res://.godot/exported/133200997/export-daf010845257121816365d93c5fd8bc3-UI.scn"
 list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             \'5�7E   res://Scenes/Bullet/Bullet.tscn�����r)    res://Scenes/Game/Game.tscn�(h��hd/   res://Scenes/Large_Asteroid/Large_Asteroid.tscn��HiF��h1   res://Scenes/Medium_Asteroid/Medium_Asteroid.tscn�'?���Z   res://Scenes/Player/Player.tscn���}\�M/   res://Scenes/Small_Asteroid/Small_Asteroid.tscn��FnI�9+   res://Scenes/Start_Screen/Start_Screen.tscn?z'*���{   res://Scenes/UI/UI.tscn��|($   res://Sprites/Big_Asteroid-1.png.png�-���l�%   res://Sprites/Bullet-1.png.pngΡG�*�
w'   res://Sprites/Medium_Asteroid-2.png.png��(s�fZ   res://Sprites/Player-1.png.png,P�Y9&   res://Sprites/Small_Asteroid-3.png.png�Y$�L��Q   res://icon.svg               ECFG      application/config/name         AsteroidsWorkshop      application/run/main_scene4      +   res://Scenes/Start_Screen/Start_Screen.tscn    application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg     autoload/Globals(          *res://Global Scripts/Globals.gd"   display/window/size/viewport_width      �  #   display/window/size/viewport_height      8     display/window/stretch/mode         viewport    file_customization/folder_colors�               res://Global Scripts/         green         res://Scenes/         red       res://Scenes/Start_Screen/        red       res://Sprites/        blue   input/thrust�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script         input/rotate_left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script         input/rotate_right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script         input/shoot�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label             unicode           echo          script         input/Escape�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         layer_names/2d_physics/layer_1         Player     layer_names/2d_physics/layer_2         Bullets    layer_names/2d_physics/layer_3      	   Asteroids   9   rendering/textures/canvas_textures/default_texture_filter                  