# Session 1  * Getting Godot and the project set up/creating the start screen
## Install Godot 
* [Download](https://godotengine.org/download) Latest Download of Godot

## Download the Assets
https://github.com/CoilSeb/AsteroidsWorkshop/blob/edd8209c42c4aaa776ef1afbe82ff2e8e62b9fe2/Sprites.zip

## Starting the Project
* Open Godot
* Click on New 
* Select the folder you want to save the project in and name the project.
* Click on Create and Edit 

## Editing the Project Settings 
* Click on `Project`
* Click on `Project Settings`
* Click on `Window`
* Change the Window Size to `1920 x 1080`
* Change the `Stretch` `Mode` to viewport
* Click on `Textures`
* Change the Default Texture Filter to `Nearest`

## Creating the Start Screen 
* Click on `User Interface`
* Name the scene `Start_Screen`
* Save the scene

## Creating the Start Game and Exit Buttons
* Right-Click on the `Control` node and click on `Add Child Node`
* Search for `Button` and click on it and the `Create` button
* Rename the `Button` node to `Start_Button`
* Click on the `Start_Button` node in the scene
* Change the `Text` to `Start Game`
* Change the anchor to `Center`
* Under `Theme Overrides` click on `Font Sizes` and change the font size to `100`
* Right-Click on the `Start_Button` node and click on `Duplicate`
* Rename the new `Button` node to `Exit`
* Click on the `Exit` node in the scene
* Change the `Text` to `Exit`
* Add `200` to the `Y` value in the `Position` section
* Right-Click on `Control` node and click on `Add Child Node`
* Search for `Label` and click on it and the `Create` button
* Rename the `Label` node to `Title`
* Click on the `Title` node in the scene
* Change the `Text` to `Asteroids` 
* Change the anchor to `Top-Center`
* Under `Theme Overrides` click on `Font Sizes` and change the font size to `300`

## Start coding the Start Screen
* Right-Click on `Start_Screen` node and click on `Attach Script`
* Click `Create`
* Click on `Start_Button` node in the scene
* Click on the `Node` tab
* Click on the `Signals` tab
* Click on the `pressed()` signal
* Click on the `Connect` button
* Click on the `Exit` node in the scene
* Click on the `Node` tab
* Click on the `Signals` tab
* Click on the `pressed()` signal
* Click on the `Connect` button
* Save with `Ctrl + S`

## Adding the Game Scene
* Click on the `+` button at the top to add a new scene 
* Click on `2D Scene`
* Name the scene `Game`
* Save the scene

## Finishing coding the Start Screen
* Go back to the `Start_Screen.gd` script in the `Script` tab
* Add the following code to the `_on_start_Button_pressed()` function
```
func _on_start_Button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")
```
* Add the following code to the `_on_exit_pressed()` function
```
func _on_exit_pressed():
	get_tree().quit()
```
* In the process function, add the following code
```
if Input.is_action_just_pressed("shoot"):
	_on_start_button_pressed()
```
* Make sure to save often with `Ctrl + S`!!!



# Session 2  * Creating the player and player movement
## Creating the Player 
* Click on the `+` button at the top to add a new scene
* Click on `Other Node` and search for `CharacterBody2D` and click on it and the `Create` button
* Rename the `CharacterBody2D` node to `Player`
* Click on the `Player` node in the scene
* Add a `Sprite2D` node as a child node to the `Player` node
* Drag your image that you will use for your player into the `Texture` section of the `Sprite2D` node
* Add a `CollisionPolygon2D` node as a child node to the `Player` node
* Create your polygon2D by adding points around the player sprite
* Add an `Area2D` node as a child node to the `Player` node
* Copy and paste (Ctrl+C, Ctrl+V) the `CollisionPolygon2D` we made earlier as a child node to the `Area2D` node
* Add a `Timer` node as a child node to the `Player` node and name it `Shoot_Timer`
* In the `Shoot Timer` inspector, change the `Wait Time` to `0.35`, the `One Shot` to `On`, and the `Autostart` to `On`
* Click on the `Player` node in the scene
* Click on the `Transform` tab underneath the `Node2D` tab
* Click on the chain icon next to the `Scale` section to unlock the `X` and `Y` values
* Set the `Scale` to `0.25` for `X` and `0.35` for `Y`
* Relock the `Scale` by clicking on the chain icon again## Creating the Player Script
* Right-Click on the `Player` node and click on `Attach Script`
* Click `Create`
* Delete all the code in the `-physics_process(delta)` function
* Delete all the variables above this script too.
* The script should be essentially empty now.
* Add these variables to the top of the script
```
@onready var shoot_timer = $Shoot_Timer
var screen_size
var thrust = 50 
var rotateSpeed = 5
var slowDown = 1
var immune = true
```

## Create the player movement and shooting mechanics
* First lets add what keys we want our player to use to move and shoot
* In the top left corner of the Godot editor, click on `Project`, `Project Settings`, and then `Input Map`
* Click on `Add New Action` and name it `Thrust`
* Click `Add`
* Click on the `+` button next to `thrust` and press `W`, followed by clicking `Okay`
* Now we will do the same for the rest of the keys
* `A` key for `rotate_left`, `D` key for `rotate_right`, and `Space` key for `shoot`
* Now we will add the code to the `Player` script
* Add the following code to the `_physics_process(delta)` function
```
if Input.is_action_pressed("rotate_left"):
	rotation += -1 * rotateSpeed * delta
if Input.is_action_pressed("rotate_right"):
	rotation += 1 * rotateSpeed * delta
```
* Now to add the thrust
* Add the following code to the `_physics_process(delta)` function
```
if Input.is_action_pressed("thrust"):
	velocity += ((Vector2(0, -1) * thrust * delta).rotated(rotation))
	immune = false
	
move_and_collide(velocity * delta)
```
* Next we will add the code for slowing down and stopping our player
* Add the following code to the `_physics_process(delta)` function above the `move_and_collide()` function

```
else:
	velocity = lerp(velocity, Vector2.ZERO, slowDown * delta)
	if velocity.length() >= -10 && velocity.length() <= 10:
		velocity = Vector2.ZERO
```
* Now we will add the code for screen wrapping
* First we have to get the size of our screen
* Create the ready function by typing `func _ready():` above your `_physics_process(delta)` function and underneath the variables
* Add the following code to the `_ready()` function
```
screen_size = get_viewport_rect().size
```
* Add the following code directly underneath the `_physics_process(delta)` function above the input code
```
if position.x < 0:
	position.x = screen_size.x
if position.x > screen_size.x:
	position.x = 0
if position.y < 0:
	position.y = screen_size.y
if position.y > screen_size.y:
	position.y = 0
```


# Session 3  * Create asteroids and spawning
## Creating the Small Asteroid
* Click on the `+` button at the top to add a new scene
* Click on `Other Node` and search for `Area2D` and click on it and the `Create` button
* Rename the `Area2D` node to `Small_Asteroid`
* Now we need to give it a sprite and a collision shape like we did with the player
* Add a `Sprite2D` node as a child node to the `Small_Asteroid` node
* Drag your image that you will use for your asteroid into the `Texture` section of the `Sprite2D` node
* Add a `CollisionPolygon2D` node as a child node to the `Small_Asteroid` node
* Create your polygon2D by adding points around the asteroid sprite
* Save this with `Ctrl + S` and name it `Small_Asteroid.tscn`
* Click on the `Small Asteroid` node in the scene, right click on it, and click on `Attach Script`
* Click `Create`    
* Start off by making a few variables at the top of the script
```
var screen_size
var speed
var rotation_speed
var direction
```
* Now we will add the code to the `_ready()` function
```
screen_size = get_viewport_rect().size
```
* We will go ahead and implement the screen wrapping code for the asteroids
* Add the following code to the `_physics_process(delta)` function
```
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
```
* Now we need to make it move in a random direction upon spawning
* We will do this by writing a new function called `set_direction_and_speed()`
* Add the following code to the `set_direction_and_speed()` function
```
var angle = randf_range(0, 2 * PI)  # Random angle in radians
direction = Vector2(cos(angle), sin(angle))  # Convert angle to direction vector
speed = randf_range(75, 200)  # Random speed between 75 and 200
rotation_speed = randf_range(-1, 1)  # Random rotation speed between -1 and 1
```
* Now we will call this function in the `_ready()` function
* Add the following code to the `_ready()` function
```
set_direction_and_speed()
```
* Now we will connect the signal `tree_exited` to our script
* Add the following code to the `_on_tree_exited()` function
```
print("Dead")
```
* To test this we can add a couple of lines of code to `process(delta)` function
```
if Input.is_action_just_pressed("shoot"):
	queue_free()
```
* Add a `Small_Asteroid` node as a child node to the `Game` node to test it out
* We should see that pressing the `Space` key will destroy the asteroid

## Creating the Medium Asteroid
* We will follow the same steps as we did for the small asteroid
* Click on the `+` button at the top to add a new scene
* Click on `Other Node` and search for `Area2D` and click on it and the `Create` button
* Rename the `Area2D` node to `Medium_Asteroid`
* Now we need to give it a sprite and a collision shape like we did with the player
* Add a `Sprite2D` node as a child node to the `Medium_Asteroid` node
* Drag your image that you will use for your asteroid into the `Texture` section of the `Sprite2D` node
* Add a `CollisionPolygon2D` node as a child node to the `Medium_Asteroid` node
* Create your polygon2D by adding points around the asteroid sprite
* Save this with `Ctrl + S` and name it `Medium_Asteroid.tscn`
* Click on the `Medium Asteroid` node in the scene, right click on it, and click on `Attach Script`
* Click `Create`
* We will copy and paste the code from the `Small_Asteroid` script into the `Medium_Asteroid` script (To do this easily, click on the `Small_Asteroid` script, press `Ctrl + A` to select all the code we want to copy, press `Ctrl + C` to copy the code, click on the `Medium_Asteroid` script, press `Ctrl+A` to select all the code we want to replace, and press `Ctrl + V` to paste the code)
* Now we will add a new variable to the top of the script
```
const SMALL_ASTEROID = preload("") 
```
* You will need to put the path to the `Small_Asteroid.tscn` file in the `preload()` function inbetween the quotation marks
* For example, if your `Small_Asteroid.tscn` file is in the `Scenes` folder, you would put `preload("res://Scenes/Small_Asteroid.tscn")`
* Each additional folder you have to go through to get to the file will need to be added to the path with a `/` inbetween each folder
* If it isn't in any folders, you can just put `preload("res://Small_Asteroid.tscn")`
* An easy way to do this is to drag the file from the `FileSystem` tab into the script and hold `Ctrl` while you let go of the mouse button
* Next we will create a new function called `create_and_add_asteroids` that will be called when we destroy the medium asteroid
* Add the following code to the `create_and_add_asteroids` function
```
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
```
* Now we will call this function in the `destroy()` function
* Replace `queue_free()` in the `destroy()` function
```
call_deferred("create_and_add_asteroids")
```
* Now add a `Medium_Asteroid` node as a child node to the `Game` node to test it out
* We should see that pressing the `Space` key will destroy the asteroid and spawn two small asteroids in its place

## Creating the Large Asteroid
* We will follow the same steps as we did for the small and medium asteroid
* Click on the `+` button at the top to add a new scene
* Click on `Other Node` and search for `Area2D` and click on it and the `Create` button
* Rename the `Area2D` node to `Large_Asteroid`
* Now we need to give it a sprite and a collision shape like we did with the player
* Add a `Sprite2D` node as a child node to the `Large_Asteroid` node
* Drag your image that you will use for your asteroid into the `Texture` section of the `Sprite2D` node
* Add a `CollisionPolygon2D` node as a child node to the `Large_Asteroid` node
* Create your polygon2D by adding points around the asteroid sprite
* Save this with `Ctrl + S` and name it `Large_Asteroid.tscn`
* Click on the `Large Asteroid` node in the scene, right click on it, and click on `Attach Script`
* Click `Create`
* Copy and paste the code from the `Medium_Asteroid` script into the `Large_Asteroid` script (See medium asteroid section for how to do this if you forgot how)
* Now we will change some variables around
* Instead of `const SMALL_ASTEROID = preload("")` we will change it to `const MEDIUM_ASTEROID = preload("")`
* Then we need to change the name and our variables in the `create_and_add_asteroids()` function
* Change the name of the function to `create_and_add_asteroids()`
* Change the variable names from `small_asteroid1` and `small_asteroid2` to `medium_asteroid1` and `medium_asteroid2`
* Change the variable names from `SMALL_ASTEROID.instantiate()` to `MEDIUM_ASTEROID.instantiate()`
* Throw in a large asteroid into the `Game` scene to test it out
* We should see that pressing the `Space` key will destroy the asteroid and spawn two medium asteroids in its place

## Creating the Asteroid Spawner
* Click on your `Game` scene. We will use this to house our spawning mechanics
* Add a `Timer` node as a child node to the `Game` node and name it `Spawn_Timer`
* Now add a script to the `Game` node
* Now we add some variables to the top of the script
```
@onready var spawn_timer = $Spawn_Timer
var screen_size
var asteroid_scenes = {
	0: preload(""),
	1: preload(""),
	2: preload("")
}
```
* Add your asteroid scenes to the `asteroid_scenes` dictionary
* First things first we will need our `ready()` function to get our screen size
* Add the following code to the `ready()` function
```
screen_size = get_viewport().get_visible_rect().size
```
* Now we will create a few new functions
* First we will create a function called `spawn_asteroid()`
* Add the following code to the `spawn_asteroid()` function
```
var new_asteroid = asteroid_scenes[randi_range(0,2)].instantiate()
add_child(new_asteroid)
new_asteroid.position = generate_spawn_point()
```
* Now we will create a new function called `random_vector`
* Add the following code to the `random_vector()` function
```
return Vector2(randf_range(left, right), randf_range(bottom, top))
```
* Now we will create a function called `generate_spawn_point()`
* Add the following code to the `generate_spawn_point()` function
```
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
```
* Now to trigger the spawning we have to go into our timers inspector and click on the `Timeout` signal
* Click on our `Spawn_Timer` node in the scene
* Click on the `Node` tab next to the `Inspector` tab
* Make sure you're on the `Signals` tab
* Double click on the `Timeout` signal
* Click on the `Connect` button
* Now we will add the code to the `_on_Spawn_Timer_timeout()` function
```
spawn_asteroid()
```
* Open the game up and watch the asteroids spawn


# Session 4 * Shooting and scoring
## Creating the Bullet
* Make a new scene called `Bullet`. Make it a `Area2D`
* Add a `Sprite2D` node as a child node to the `Bullet` node
* Drag your image that you will use for your bullet into the `Texture` section of the `Sprite2D` node
* Add a `CollisionShape2D` node as a child node to the `Bullet` node
* Create your collision shape around the bullet sprite
* Save this with `Ctrl + S` and name it `Bullet.tscn`
* Click on the `Bullet` node in the scene, right click on it, and click on `Attach Script`
* Click `Create`
* Add the following variables to the top of the script
```
var direction: Vector2
var bullet_speed = 700
var screen_size
```
* Add the following code to the `_ready()` function
```
screen_size = get_viewport_rect().size
```
* Add the following code to the `_physics_process(delta)` function
```
position += direction * bullet_speed * delta
if position.x < 0:
	queue_free()
if position.x > screen_size.x:
	queue_free()
if position.y < 0:
	queue_free()
if position.y > screen_size.y:
	queue_free()
```
* Now we will add a function to detect collisions
* Click on the `Bullet` node in the scene
* Click on the `Node` tab
* Find the `area_entered()` signal and double click on it
* Click on the `Connect` button
* Add the following code to the `_on_area_entered()` function
```
area.destroy()
queue_free()
```

## Layering and Masking
* We need to change our collision layers and masks for every in-game object so that we don't have any unwanted collisions
* Click on the `Bullet` node in the scene
* Find the `CollisionShape2D` node in the `Inspector` tab
* Click on the `Collision` tab
* We will edit and name our layers and masks by clicking on the three vertical dots next to the `Layers` and `Masks` sections
* Click on `Edit Layers` and change the `Layer 1` name to `Player`, `Layer 2` name to `Bullet`, and `Layer 3` name to `Asteroid`
* This has changed the names of the layers and the masks
* After changing the names we can click the three vertical dots again and click on `Bullets` for the layer and `Asteroids` for the mask
* Now we will do the same for the `Player` node
* Click on the `Player` node in the scene
* Find the `Collision` property in the `Inspector` tab
* Click on the three vertical dots next to the `Layers` and `Masks` sections to change the layer to `Player` and the mask to `Asteroids`
* Finally, go through all your asteroids and change their layers to `Asteroids` and turn off all their masks

## Shooting
* First, go through all your asteroids and delete the two lines of code in the `process(delta)` function that destroys the asteroids when you press the `Space` key
```
if Input.is_action_just_pressed("shoot"):
    destroy()
```
* Next, we need to create a new script that is going to save global variables and carry our games signals
* Right click on any empty space in the `FileSystem` tab and click on `New Folder`
* Name the folder `Global Scripts`
* Right click on the `Global Scripts` folder and click on `Create New` and then `Script`
* Name the script something like `Globals` or `Bus` for signal bus
* Open the script and add the following code to the top of the script
```
var score: int

signal increase_score
```
* We now have two options for where to put our signal bus
* We can either put it on the `Game` scene or we can set it to autoload
* If we put it on the `Game` scene, we will have to add it to every scene that we want to use it in
* Autoloading it will make it so that it is always loaded into the game
* To autoload it, click on `Project` at the top of the Godot editor, then click on `Project Settings`, and then click on `AutoLoad`
* Click on the `folder` icon next to the `Path` section
* Click on the `Global Scripts` folder and then click on `Globals.gd`(or whatever you named it) and then click `Open`
* Now back in our `Player` script we will add the following code to our variables at the top
```
const BULLET = preload("")
```
* Now we will add the following code to the `physics_process(delta)` function
```
if Input.is_action_pressed("shoot") && immune == false:
    var bulletInstance = BULLET.instantiate()  # Create a new instance of the Bullet scene
    get_parent().add_child(bulletInstance)  # Add it to the player node or a designated parent node for bullets
    bulletInstance.global_position = global_position  # Set the bullet's position
    bulletInstance.direction = Vector2.UP.rotated(rotation)  # Set the bullet's direction
```
* Test the game and you should see that yoou shoot a stream of bullets when you hold down the `Space` key
* This is way to fast so we will add some code to our shoot code we just wrote
* Update your code to look like this
```
if Input.is_action_pressed("shoot") && immune == false && shoot_timer.time_left == 0:  # Use action_just_pressed to prevent multiple bullets on a single press
    var bulletInstance = BULLET.instantiate()  # Create a new instance of the Bullet scene
    get_parent().add_child(bulletInstance)  # Add it to the player node or a designated parent node for bullets
    bulletInstance.global_position = global_position  # Set the bullet's position
    bulletInstance.direction = Vector2.UP.rotated(rotation)  # Set the bullet's direction
    shoot_timer.start(0.35)
```
* Now we can destroy our asteroids with our bullets

## Scoring
* Now we need to add a User Interface (UI) to display our score
* Click on the `+` button at the top to add a new scene
* Click on `Other Node` and search for `CanvasLayer` and click on it and the `Create` button
* Rename the `CanvasLayer` node to `UI`
* Add a `Label` node as a child node to the `UI` node
* Rename the `Label` node to `Score_Label`
* Click on the `Score_Label` node in the scene
* Change the `Text` to `Score: 0`
* Change the Alignments to `Center` and `Center`
* Find the `Theme Overrides` section and click on `Font Sizes`
* Change the font size to `32`
* Open your `2D` view 
* Click on the `Score_Label` node in the scene
* Find the presets for the anchor and anchor the `Score_Label` to the top center of the screen
* Add your `UI` scene as a child node to the `Game` scene
* Add a script to your `UI` scene
* Create a new function called `update_score(value)`
* In the ready function add the following code
```
Globals.connect("increase_score", update_score)
```
* Add the following code to the `update_score(value)` function
```
Globals.score += value
$Score_Label.text = "Score: " + str(Globals.score)
```
* Now we will add the following code to the `destroy()` function in the `Small_Asteroid` script
```
Globals.increase_score.emit(300)
```
* Now we will add the following code to the `destroy()` function in the `Medium_Asteroid` script
```
Globals.increase_score.emit(200)
```
* Now we will add the following code to the `destroy()` function in the `Large_Asteroid` script
```
Globals.increase_score.emit(100)
```
* Let's test it out and see if our score is updating


# Session 5 * Game over and restart (game saves)
## Setting up a Lives System
* Lets start by adding how many lives we want to have to our `Globals` script
* Add the following code to the top of the `Globals` script
```
var lives = 3 
```
* Now we will add some more features to our `UI` scene
* In your 2D view, click on the `UI` node in the scene
* Add a `Label` node as a child node to the `UI` node
* Rename the `Label` node to `Lives_Label`
* Click on the `Lives_Text_Label` node in the scene
* Change the `Text` to `Lives: `
* Change the Alignments to `Center` and `Center`
* Find the `Theme Overrides` section and click on `Font Sizes`
* Change the font size to `32`
* Click on the `Lives_Label` node in the scene
* Find the presets for the anchor and anchor the `Lives_Label` to the top left of the screen
* We will then make three `TextureRect` nodes to represent our lives
* Create a `TextureRect` node as a child node to the `UI` node
* Rename the `TextureRect` node to `Life1_Texture`
* Click on the `Life1_Texture` node in the scene
* Add our `Player` sprite to the `Texture` section of the `TextureRect` node
* Set the `Expand Mode` to `Ignore Size`
* Find the `Transform` section in the `Layout` section and change the `Scale` to `25` for `X` and `35` for `Y`
* Set the position to `100` for `X` and `5` for `Y`
* Copy and paste the `Life1_Texture` node twice and rename it to `Life2_Texture` and `Life3_Texture`
* Change the `X` position of the `Life2_Texture` node to `135` and the `Life3_Texture` node to `170`
* Now we will add a new function to our `UI` scene
* Create a function called `update_lives(player)`
* Add the following code to the `update_lives(player)` function
```
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
	player.queue_free()
	$Life1_Texture.visible = false
```

## Detecting Damage
* Now we need to detect when our player collides with an asteroid
* In your `Globals` script, add the following code to the top of the script
```
signal take_damage(player)
```
* Click on the `Player` node in the scene
* Click on the `Area2D` node
* Click on the `Node` tab
* Find the `area_entered()` signal and double click on it
* Click on the `Connect` button
* Add the following code to the `_on_area_entered()` function
```
Globals.take_damage.emit(self)
```
* Back in our `UI` script, add the following code to the `ready()` function
```
Globals.connect("take_damage", update_lives)
screen_size = get_viewport().get_visible_rect().size
```
* As well as adding the screen_size variable to the top of the script
```
var screen_size
```

## Game Over
* Now we will create a new function called `game_over()`
* Add the following code to the `game_over()` function
```
$Score_Label.set("theme_override_font_sizes/font_size", 56)
$Score_Label.position = screen_size/2 - Vector2(60, 45)
```
* We now want to save this score to a file if it is higher than the previous high score
* We will start by creating a `High_Score` label
* Click on the `UI` node in the scene
* Add a `Label` node as a child node to the `UI` node
* Rename the `Label` node to `High_Score_Label`
* Click on the `High_Score_Label` node in the scene
* Change the `Text` to `High Score: `
* Change the Alignments to `Center` and `Center`
* Find the `Theme Overrides` section and click on `Font Sizes`
* Change the font size to `128`
* Anchor it to the top center of the screen
* We now want to turn off the `High_Score_Label` when playing and turn it on when the game is over
* Click on the eye icon next to the node name in the `Scene` tab
* Now we will add the following code to the `game_over()` function
```
$High_Score_Label.visible = true
```
* Add a new variable to your globals script
```
var high_score = 0
```
* Now we will add some more code to the `game_over()` function at the top of the function, so it happens first
```
if Globals.score > Globals.high_score:
	Globals.high_score = Globals.score
	$High_Score_Label.text = "New High Score: " + str(Globals.high_score)
else: $High_Score_Label.text = "High Score: " + str(Globals.high_score)
```

## Saving the High Score
* Now we will create a new function called `save_high_score()` in our Globals script
* Add the following code to the `save_high_score()` function
```
var saved_score = FileAccess.open("user://high_score.save", FileAccess.WRITE)
var save_text = JSON.stringify({"High Score": Globals.high_score})
saved_score.store_line(save_text)
```
* While we are here, we will also create a function called `load_high_score()`
* Add the following code to the `load_high_score()` function
```
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
```
* In our `game_over()` function in the UI script, we will add the following code to our if statement
```
Globals.save_high_score()
```
* Now we will add the following code to the `ready()` function in the `Globals` script
```
high_score = load_high_score()
```
* Now lets add our high score to the start screen
* Click on the `Start_Screen` node in the scene
* Add a `Label` node as a child node to the `Control` node
* Rename the `Label` node to `High_Score_Label`
* Click on the `High_Score_Label` node in the scene
* Change the `Text` to `High Score: `
* Change the Alignments to `Center` and `Center`
* Find the `Theme Overrides` section and click on `Font Sizes`
* Change the font size to `32`
* Anchor it to the bottom center of the screen
* In your `Start_Screen` script, add the following code to the `ready()` function
```
$Control/High_Score_Label.text = "High Score: " + str(Globals.high_score)
```
* Play your game and see if your high score saves

## Making a Pause Menu
* In your `UI` scene, add a `Control` node as a child node to the `UI` node
* Rename the `Control` node to `Pause_Menu`
* Click on the `Pause_Menu` node in the scene
* Change the `Size` to `1920 x 1080` or anchor it as the full screen size
* Make a new `Button` node as a child node to the `Pause_Menu` node
* Rename the `Button` node to `Resume_Button`
* Click on the `Resume_Button` node in the scene
* Change the `Text` to `Resume`
* Change the anchor to `Center`
* Under `Theme Overrides` click on `Font Sizes` and change the font size to `52`
* Move its anchor to the center of the screen
* Move its `Y` position to `400`
* Copy and paste the `Resume_Button` button twice and rename it to `Exit_Button` and `Restart_Button`
* Change the text of the `Exit_Button` to `Exit` and the `Restart_Button` to `Restart`
* Move the `Exit_Button` to `Y` position `600` and the `Restart_Button` to `Y` position `500` if it isn't already there
* Add a `ColorRect` node as a child node to the `Pause_Menu` node
* Rename the `ColorRect` node to `Dim_Overlay`
* Make it the same size as the `Pause_Menu`, aka full screen
* Change the `Color` to `Black` and the `A` value to `75`
* Now make the `Pause_Menu` not visible by clicking on the eye icon next to the node name in the `Scene` tab
* Add a new function to the `UI` script called `toggle_pause_menu()`
* Add the following code to the `toggle_pause_menu()` function
```
get_tree().paused = not get_tree().paused
$Pause_Menu.visible = !$Pause_Menu.visible
```
* No we will add a pause button to our UI
* Add a `Button` node as a child node to the `UI` node
* Rename the `Button` node to `Pause_Button`
* Click on the `Pause_Button` node in the scene
* Change the `Texture` to a pause icon
* Change the `Anchor` to the top right of the screen
* Change the `Icon Behavior` to `Icon Alignment` `Center` and `Center`
* Change the `Icon Behavior` `Expand Icon` on
* Connect the node to the `UI` script
* Add the following code to the `_on_Pause_Button_pressed()` function
```
toggle_pause_menu()
```
* Go to your `Project Settings` and click on the `Input Map` tab
* Add a new action called `Escape`
* Click on the `+` button next to the `Escape` action and press the `Esc` key
* Now we will add the following code to the `ready()` function
```
if Input.is_action_just_pressed("Escape"):
	toggle_pause_menu()
```
* Click on your `UI` node and change its process mode to `Always`
* Connect the `pressed()` signal of all of your `Pause_Menu` buttons to the `UI` script
* Add the following code to the `_on_Resume_Button_pressed()` function
```
toggle_pause_menu()
```
* Add the following code to the `_on_Exit_Button_pressed()` function
```
toggle_pause_menu()
get_tree().change_scene_to_file("res://Scenes/Start_Screen/Start_Screen.tscn")
```
* Lets add a new function to our `Globals` script called `reset_variables()`
* Add the following code to the `reset_variables()` function
```
score = 0
lives = 3
```
We will create a new function called restart
* Add the following code to the `restart()` function
```
if get_tree().paused:
	toggle_pause_menu()
get_tree().reload_current_scene()
Globals.reset_variables()
```
* Add the following code to the `_on_Restart_Button_pressed()` function
```
restart()
```
* Now we will add the following code to the `_process` function in the `UI` script
```
if $Restart_Button.visible == true && Input.is_action_just_pressed("shoot"):
	restart()
```
* Now go to your `Start_Screen` script and add the following code to the `_on_start_game_pressed()` function
```
Globals.reset_variables()
```

## Restarting the Game on Death
* Copy the `Restart_Button` node from the `Pause_Menu` node
* Paste it as a child node to the `UI` node
* Set its font size to 100
* Set its `Y` position to 650
* Set the visiblity to false
* The code we already wrote for the restart button should apply to this button as well
* Now we will add the following code to the `game_over` function in the `UI` script
```
$Restart_Button.visible = true
```
* Now our game should restart when we press the restart button


# Session 6 * Final touch ups and exports
## Exporting the Game
* Click on `Project` at the top of the Godot editor
* Click on `Export`
* Click on the `Windows Desktop` icon or whatever platform you want to export to
* Click on the `Add` button
* Click on the `Browse` button
* Find the folder you want to export to and click `Select Folder`
* Click on the `Export Project` button
* Wait for it to finish exporting
* Go to the folder you exported to and click on the `.exe` file to play your game

## Bonus Stuff
### Adding Commas to the Score
* If we want to add commas to our score, we can refactor some code
* Add a function called get_score_text(number) to your `Globals` script
* Add the following code to the `get_score_text(number)` function
```
var score_string = str(number)
var score_text = ""
for i in range(len(score_string)):
	score_text += score_string[i]
	var distance = len(score_string) - i
	if distance != 1 and distance % 3 == 1:
		score_text += ","
return score_text
```
* Now update the following functions in your `UI` script
* In the `update_score(value)` function
```
Globals.score += value
$Score_Label.text = "Score: " + Globals.get_score_text(Globals.score)
```
* Make the `Game_Over` function look like this
```
if Globals.score > Globals.high_score:
	Globals.high_score = Globals.score
	$High_Score_Label.text = "New High Score: " + Globals.get_score_text(Globals.high_score)
	Globals.save_high_score()
else: $High_Score_Label.text = "High Score: " + Globals.get_score_text(Globals.high_score)
$Score_Label.set("theme_override_font_sizes/font_size", 56)
$Score_Label.position.y = screen_size.y/2 - 45
$High_Score_Label.visible = true
$Restart_Button.visible = true
```
* Finally in your `Start_Screen` script, change the `ready()` function
```
$Control/High_Score_Label.text = "High Score: " + Globals.get_score_text(Globals.high_score)
```

### Adding Mouse Controls
* Add the following variables to the top of the `Player` script
```
var using_mouse = false
```
* Now go into your `Input Map` and give thrust the `Mouse Button Left` action and shoot the `Mouse Button Right` action
* Now change up your inputs to add the new things to the `physics_process(delta)` function
```
if Input.is_action_pressed("rotate_left"):
	rotation += -1 * rotateSpeed * delta
	using_mouse = false                                                                                    // New
	immune = false
if Input.is_action_pressed("rotate_right"):
	using_mouse = false                                                                                    // New
	immune = false
	rotation += 1 * rotateSpeed * delta
if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) || Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):  // New
	using_mouse = true                                                                                     // New
if using_mouse:                                                                                            // New
	rotate(get_angle_to(get_global_mouse_position()) + (0.5 * PI))                                         // New
if Input.is_action_pressed("thrust"):
	velocity += ((Vector2(0, -1) * thrust * delta).rotated(rotation))
	immune = false
else:
	velocity = lerp(velocity, Vector2.ZERO, slowDown * delta)
	if velocity.y >= -1 && velocity.y <= 1:
		velocity.y = 0
```
* Notice how we added a new `If` statement to check if the mouse is being used and since we added the controls to thrust and shoot, we don't have to write anymore code to make the mouse work