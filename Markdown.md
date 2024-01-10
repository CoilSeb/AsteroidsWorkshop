# Session 1
## Install Godot 
* [Download](https://godotengine.org/download) Latest Download of Godot

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
* Chnage the `Stretch` `Mode` to viewport
* Click on `Textures`
* Change the Default Texture Filter to `Nearest`

## Creating the Start Screen 
* Click on `2D Scene`
* Name the scene `Start_Screen`
* Save the scene
* Click the + button to add a new node to the scene 

## Creating the Start Screen UI
* Search for `Control` and click on it and the `Create` button 
* Click on the `Control` node in the scene
* Click on the `Layout` tab
* In the `Transform` section, change the `Size` to `1920 x 1080`

## Creating the Start Game and Exit Buttons
* Right-Click on the `Control` node and click on `Add Child Node`
* Search for `Button` and click on it and the `Create` button
* Rename the `Button` node to `Start_Game`
* Click on the `Start_Game` node in the scene
* Change the `Text` to `Start Game`
* Change the anchor to `Center`
* Under `Theme Overrides` click on `Font Sizes` and change the font size to `100`
* Right-Click on the `Start_Game` node and click on `Duplicate`
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
* Click on `Start_Game` node in the scene
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
* Add the following code to the `_on_start_game_pressed()` function
```gdscript
func _on_start_game_pressed():
    get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")
```
* Add the following code to the `_on_exit_pressed()` function
```gdscript
func _on_exit_pressed():
    get_tree().quit()
```
* Make sure to save often with `Ctrl + S`!!!


# Session 2
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
    
move_and_collide(velocity * delta)
```
* Next we will add the code for slowing down and stopping our player
* Add the following code to the `_physics_process(delta)` function above the `move_and_collide()` function

```
else:
    velocity = lerp(velocity, Vector2.ZERO, slowDown * delta)
    if velocity.y >= -1 && velocity.y <= 1:
        velocity.y = 0
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


# Session 3 * Create asteroids and spawning
## Creating the Asteroids
* Click on the `+` button at the top to add a new scene
* Click on `Other Node` and search for `Area2D` and click on it and the `Create` button
* Rename the `Area2D` node to `Small_asteroid`


# Session 4 * Shooting and scoring


# Session 5 * Game over and restart (game saves)


# Session 6 * Final touch ups and exports
