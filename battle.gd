extends ColorRect

enum Menu {MAIN, FIGHT, PACK, PKMN, RUN}

const SELECT_FIGHT = 0
const SELECT_PACK := 1
const SELECT_PKMN := 2
const SELECT_RUN := 3

var current_menu := Menu.MAIN

var selected := 0

func _physics_process(_delta: float) -> void:
    match current_menu:
        Menu.MAIN:
            handle_menu_main()
        Menu.FIGHT:
            if Input.is_action_just_pressed("move_down"):
                selected = (selected + 1) % 4
            elif Input.is_action_just_pressed("move_up"):
                selected = (selected - 1 + 4) % 4
            match selected:
                0:
                    %SpriteArrow.position = Vector2(44, 108)
                1:
                    %SpriteArrow.position = Vector2(44, 116)
                2:
                    %SpriteArrow.position = Vector2(44, 124)
                3:
                    %SpriteArrow.position = Vector2(44, 132)

func handle_menu_main() -> void:
    match selected:
        SELECT_FIGHT: # fight
            if Input.is_action_just_pressed("move_down"):
                selected = SELECT_PACK
            elif Input.is_action_just_pressed("move_right"):
                selected = SELECT_PKMN
            elif Input.is_action_just_pressed("select"):
                fight()
        SELECT_PKMN:
            if Input.is_action_just_pressed("move_down"):
                selected = SELECT_RUN
            elif Input.is_action_just_pressed("move_left"):
                selected = SELECT_FIGHT
            elif Input.is_action_just_pressed("select"):
                pkmn()
        SELECT_PACK:
            if Input.is_action_just_pressed("move_up"):
                selected = SELECT_FIGHT
            elif Input.is_action_just_pressed("move_right"):
                selected = SELECT_RUN
            elif Input.is_action_just_pressed("select"):
                pack()
        SELECT_RUN:
            if Input.is_action_just_pressed("move_up"):
                selected = SELECT_PKMN
            elif Input.is_action_just_pressed("move_left"):
                selected = SELECT_PACK
            elif Input.is_action_just_pressed("select"):
                run()

    match selected:
        SELECT_FIGHT:
            %SpriteArrow.position = Vector2(76, 116)
        SELECT_PKMN:
            %SpriteArrow.position = Vector2(124, 116)
        SELECT_PACK:
            %SpriteArrow.position = Vector2(76, 132)
        SELECT_RUN:
            %SpriteArrow.position = Vector2(124, 132)


func fight() -> void:
    selected = 0
    current_menu = Menu.FIGHT
    %LayerMenu.hide()
    %LayerFight.show()

func pkmn() -> void:
    pass

func pack() -> void:
    pass

func run() -> void:
    pass
