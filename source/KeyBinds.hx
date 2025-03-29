import flixel.input.keyboard.FlxKey;

class KeyBinds {
    public static var Keys:Map<String, FlxKey> = 
    [
        "JUMP_PLAYER1" => W,
        "MOVE_LEFT_PLAYER1" => A,
        "MOVE_RIGHT_PLAYER1" => D,
        "CROUCH_PLAYER1" => S,
        "DASH_PLAYER1" => SHIFT,
        "ATTACK_PLAYER1" => F,

        "JUMP_PLAYER2" => I,
        "MOVE_LEFT_PLAYER2" => J,
        "MOVE_RIGHT_PLAYER2" => L,
        "CROUCH_PLAYER2" => K,
        "DASH_PLAYER2" => N,
        "ATTACK_PLAYER2" => SEMICOLON,
    ];
}