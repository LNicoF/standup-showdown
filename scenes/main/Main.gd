extends Control

func _on_PlayButton_pressed():
    var _res = get_tree().change_scene( "res://scenes/duel/Duel.tscn" )

func _on_LoadingScreen_finished():
    $LoadingScreen/PlayButton.show()

