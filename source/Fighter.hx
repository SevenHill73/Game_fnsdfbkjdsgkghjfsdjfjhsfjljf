package;
import flixel.util.FlxColor;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxSprite;
using flixel.util.FlxSpriteUtil;
enum Moveset {
    Jab;
    ForwardTilt;
    UpTilt;
    DownTilt;
}
class Fighter extends FlxSprite {

    //This is for the short hop and the full hop
	var jumpTimer:Int = 0;

	// Basic Properties
	var WALKING_SPEED:Float = 1;
	var RUNNING_SPEED:Float = 1;
	var FALLING_SPEED:Float = 1;
	var JUMP_HEIGHT:Float = 1;

    //Double Jump
	var maximumAirJump = 1;

	// Status
	var FALLING:Bool = true;
	var RUNNING:Bool = true;

	var JUMP = 2;

	var playerId:Int;

	public function new(characterId:Int,playerId:Int)
	{
        super();
		this.playerId = playerId;
		//maxVelocity.y = 500;
        JUMP = maximumAirJump + 1;
		switch (characterId)
		{
			case 1:
				maximumAirJump = 99;
                makeGraphic(20,20,FlxColor.WHITE);
				
		}
    }
    override function update(elapsed:Float){
        super.update(elapsed);
		FlxG.collide(PlayState.instance.stage.ground, this);
		for (i in PlayState.instance.stage.blastzone) 
			if(FlxG.collide(i,this)){
				kill();
			}
		hop();
		move();
        attack();
	}
    
	function formula(?type:String):Float
	{
		switch (type)
		{
			case "walk":
				return 100.0 * WALKING_SPEED;
			case 'fall':
				return 500.0 * FALLING_SPEED;
			case 'fullhop':
				return 200 * JUMP_HEIGHT;
			case 'shorthop':
				return 130.0 * JUMP_HEIGHT;
			default: // run
				return 300.0 * RUNNING_SPEED;
		}
	}

	private function move()
	{
		// Key DASH = Run
		//FlxG.keys.anyPressed([KeyBinds.Keys.get("DASH")]) ? RUNNING = true : RUNNING = false;
		// Move
		if (FlxG.keys.anyPressed([KeyBinds.Keys.get('MOVE_LEFT${playerId}')]))
		{
            facing = LEFT;
            setFacingFlip(LEFT,true,false);
			RUNNING ? velocity.x = formula() * -1 : velocity.x = formula("walk") * -1;
		}
		else if (FlxG.keys.anyPressed([KeyBinds.Keys.get('MOVE_RIGHT${playerId}')]))
		{
            facing = RIGHT;
            setFacingFlip(RIGHT,false,false);
			RUNNING ? velocity.x = formula() : velocity.x = formula("walk");
		}
		if (FlxG.keys.anyJustReleased([KeyBinds.Keys.get('MOVE_LEFT${playerId}')].concat([KeyBinds.Keys.get('MOVE_RIGHT${playerId}')])))
		{
			velocity.x = 0;
		}
	}

	private function hop()
	{
		// Short Hop and Ground Full Hop
        if (isTouching(DOWN)){
			FALLING = false;
			if (FlxG.keys.anyPressed([KeyBinds.Keys.get('JUMP${playerId}')]))
			{
                jumpTimer += 1;
                if (jumpTimer >= 6) {
					velocity.y = formula("fullhop") * -1;
                    jumpTimer = 0;
                }
            }
			if (FlxG.keys.anyJustReleased([KeyBinds.Keys.get('JUMP${playerId}')]) && jumpTimer < 6 && jumpTimer > 1)
			{
				velocity.y = formula("shorthop") * -1;
                jumpTimer = 0;
            }
        }
        
        //Full Hop In the Air
		if (FlxG.keys.anyJustPressed([KeyBinds.Keys.get('JUMP${playerId}')]))
		{
			FALLING = false;
            JUMP -= 1;
            if(!isTouching(DOWN) && JUMP > -1)
				velocity.y = formula("fullhop") * -1;
        }
		// Reset
        if(isTouching(DOWN) && (JUMP == 0 || JUMP != maximumAirJump))
            JUMP = maximumAirJump;
		if (velocity.y < -1)
			FALLING = true;
        if(FALLING)
            acceleration.y = formula('fall');
    }
    
    private function attack(){
        if(FlxG.keys.anyJustPressed([KeyBinds.Keys.get('ATTACK${playerId}')]))
			//Haxe wouldn't let me use switch for some reason
            if(FlxKey.toStringMap.get(FlxG.keys.firstJustPressed()) == KeyBinds.Keys.get("MOVE_RIGHT")){

            }  
    }
}