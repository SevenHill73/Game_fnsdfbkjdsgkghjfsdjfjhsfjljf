package;
import flixel.FlxG;
import flixel.FlxSprite;
class Fighter extends FlxSprite {
    var id:String;

    //This is for the short hop and the full hop
	var jumpTimer:Int = 0;

	// Basic Properties
	var WALKING_SPEED:Float = 1;
	var RUNNING_SPEED:Float = 1;
	var FALLING_SPEED:Float = 5;
	var JUMP_HEIGHT:Float = 5;

    //Double Jump
	var maximumAirJump = 1;

	// Status
	var FALLING:Bool = true;
	var RUNNING:Bool = false;

	var JUMP = 2;

	public function new(id:String)
	{
        super();
        this.id = id;
		//maxVelocity.y = 500;
        JUMP = maximumAirJump + 1;
		switch (id)
		{
			case 'placeholder':
				maximumAirJump = 10;
		}
    }
    override function update(elapsed:Float){
        super.update(elapsed);
		FlxG.collide(PlayState.instance.stage.ground, this);
		hop();
		move();
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
				return 200.732577 * JUMP_HEIGHT; // funny
			case 'shorthop':
				return 130.0 * JUMP_HEIGHT;
			default: // run
				return 300.0 * RUNNING_SPEED;
		}
	}

	private function move()
	{
		// Hold Key DASH = Run
		FlxG.keys.anyPressed(KeyBinds.DASH) ? RUNNING = true : RUNNING = false;
		// Move
		if (FlxG.keys.anyPressed(KeyBinds.MOVE_LEFT))
		{
			RUNNING ? velocity.x = formula() * -1 : velocity.x = formula("walk") * -1;
		}
		else if (FlxG.keys.anyPressed(KeyBinds.MOVE_RIGHT))
		{
			RUNNING ? velocity.x = formula() : velocity.x = formula("walk");
		}
		if (FlxG.keys.anyJustReleased(KeyBinds.MOVE_LEFT.concat(KeyBinds.MOVE_RIGHT)))
		{
			velocity.x = 0;
		}
	}

	private function hop()
	{
		// Short Hop and Ground Full Hop
        if (isTouching(DOWN)){
			FALLING = false;
			if (FlxG.keys.anyPressed(KeyBinds.JUMP))
			{
                jumpTimer += 1;
                if (jumpTimer >= 6) {
					velocity.y = formula("fullhop") * -1;
                    jumpTimer = 0;
                }
            }
			if (FlxG.keys.anyJustReleased(KeyBinds.JUMP) && jumpTimer < 6 && jumpTimer > 1)
			{
				velocity.y = formula("shorthop") * -1;
                jumpTimer = 0;
            }
        }
        
        //Full Hop In the Air
		if (FlxG.keys.anyJustPressed(KeyBinds.JUMP))
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
}