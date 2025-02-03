extends ColorRect

enum Menu {MAIN, FIGHT, PACK, PKMN, RUN}

const SELECT_FIGHT = 0
const SELECT_PACK := 1
const SELECT_PKMN := 2
const SELECT_RUN := 3

var current_menu := Menu.MAIN

var selected := 0

var player := Player.new()
var enemy := Player.new()

func _physics_process(_delta: float) -> void:
    match current_menu:
        Menu.MAIN:
            update_menu_main()
        Menu.FIGHT:
            if Input.is_action_just_pressed("move_down"):
                selected = (selected + 1) % player.get_total_moves()
            elif Input.is_action_just_pressed("move_up"):
                selected = (selected - 1 + 4) % player.get_total_moves()
            elif Input.is_action_just_pressed("cancel"):
                goto_main()
            match selected:
                0:
                    %SpriteArrow.position = Vector2(44, 108)
                1:
                    %SpriteArrow.position = Vector2(44, 116)
                2:
                    %SpriteArrow.position = Vector2(44, 124)
                3:
                    %SpriteArrow.position = Vector2(44, 132)
            update_menu_fight()

    %LabelName.text = player.get_current_monster().name.to_upper()
    %LabelLevel.text = str(player.get_current_monster().level)
    %LabelHP.text = str(player.get_current_monster().health)
    %LabelHPTotal.text = str(player.get_current_monster().get_max_hp())
    %BarHP.value = player.get_current_monster().get_hp_percent()

    %LabelEnemyName.text = enemy.get_current_monster().name.to_upper()
    %LabelEnemyLevel.text = str(enemy.get_current_monster().level)
    %BarEnemyHP.value = enemy.get_current_monster().get_hp_percent()

func update_menu_main() -> void:
    match selected:
        SELECT_FIGHT: # fight
            if Input.is_action_just_pressed("move_down"):
                selected = SELECT_PACK
            elif Input.is_action_just_pressed("move_right"):
                selected = SELECT_PKMN
            elif Input.is_action_just_pressed("select"):
                goto_fight()
        SELECT_PKMN:
            if Input.is_action_just_pressed("move_down"):
                selected = SELECT_RUN
            elif Input.is_action_just_pressed("move_left"):
                selected = SELECT_FIGHT
            elif Input.is_action_just_pressed("select"):
                goto_pkmn()
        SELECT_PACK:
            if Input.is_action_just_pressed("move_up"):
                selected = SELECT_FIGHT
            elif Input.is_action_just_pressed("move_right"):
                selected = SELECT_RUN
            elif Input.is_action_just_pressed("select"):
                goto_pack()
        SELECT_RUN:
            if Input.is_action_just_pressed("move_up"):
                selected = SELECT_PKMN
            elif Input.is_action_just_pressed("move_left"):
                selected = SELECT_PACK
            elif Input.is_action_just_pressed("select"):
                goto_run()

    match selected:
        SELECT_FIGHT:
            %SpriteArrow.position = Vector2(76, 116)
        SELECT_PKMN:
            %SpriteArrow.position = Vector2(124, 116)
        SELECT_PACK:
            %SpriteArrow.position = Vector2(76, 132)
        SELECT_RUN:
            %SpriteArrow.position = Vector2(124, 132)

func goto_main() -> void:
    selected = 0
    current_menu = Menu.MAIN
    %LayerFight.hide()
    %LayerMenu.show()

func goto_fight() -> void:
    selected = 0
    current_menu = Menu.FIGHT
    %LayerMenu.hide()
    %LayerFight.show()

    var move_0 := player.get_move(0)
    var move_1 := player.get_move(1)
    var move_2 := player.get_move(2)
    var move_3 := player.get_move(3)

    if move_0:
        %LabelMove0.text = move_0.name.to_upper()
    if move_1:
        %LabelMove1.text = move_1.name.to_upper()
    if move_2:
        %LabelMove2.text = move_2.name.to_upper()
    if move_3:
        %LabelMove3.text = move_3.name.to_upper()

func update_menu_fight() -> void:

    var move := player.get_move(selected)

    if move:
        %LabelType.text = move.type.to_upper()
        %LabelPPTotal.text = str(move.pp)
        %LabelPP.text = str(player.get_move_pp(selected))
    else:
        %LabelType.text = ""
        %LabelPPTotal.text = ""
        %LabelPP.text = ""

    if Input.is_action_just_pressed("select"):
        # do the above move
        var damage := move.get_damage_against(player.get_current_monster(), enemy.get_current_monster())
        enemy.get_current_monster().hurt(damage)
        print("damage for %d" % damage)
        if enemy.get_current_monster().health == 0:
            %AnimationPlayer.play("enemy_death")


func goto_pkmn() -> void:
    pass

func goto_pack() -> void:
    pass

func goto_run() -> void:
    pass
