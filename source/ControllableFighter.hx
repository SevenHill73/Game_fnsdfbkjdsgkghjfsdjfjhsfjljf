package;

import openfl.utils.Assets;
import haxe.Json;
import lime.app.Event;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import tjson.TJSON as Json;
using flixel.util.FlxSpriteUtil;
class ControllableFighter extends FighterBasic{
    //This is for the short hop and the full hop
	var jumpTimer:Int = 0;
	//This is for tilts/chargeable attack
	var attackTimer:Int = 0;
	
	public var playerId:Int = 1;

	public function new(characterId:Int,playerId:Int) {
		super(characterId);
		this.playerId = playerId;
		animation.onFinish.add((a)->{animation.play('idle');});
	}
    override function update(elapsed:Float){
        super.update(elapsed);
		FlxG.collide(PlayState.instance.stage.ground, this);
		AIRBORN = isTouching(DOWN) ? false : true;
		for (i in PlayState.instance.stage.blastzone) 
			if(FlxG.collide(i,this))
				kill();
		hop();
		move();
		setMoves(); //add new moves in this function
	}
    

	function move()
	{
		// Key DASH = Run
		justPressed('dash', true) ? RUNNING = true : RUNNING = false;
		// Move
		if (justPressed('move_left', true))
		{
            facing = LEFT;
            setFacingFlip(LEFT,true,false);
			RUNNING ? velocity.x = formula() * -1 : velocity.x = formula("walk") * -1;
		}
		else if (justPressed('move_right', true))
		{
            facing = RIGHT;
            setFacingFlip(RIGHT,false,false);
			RUNNING ? velocity.x = formula() : velocity.x = formula("walk");
		}
		else{
			velocity.x = 0;
		}

		velocity.x == 0 ? STILL = true : STILL = false;
	}

	function hop()
	{
		// Short Hop and Ground Full Hop
        if (!AIRBORN){
			FALLING = false;
			if (justPressed('jump',true))
			{
                jumpTimer += 1;
				if (jumpTimer >= 6){
					FALLING = false;
					JUMP -= 1;
					velocity.y = formula("fullhop") * -1;
					jumpTimer = 0;
				}
            }
			if (justReleased('jump') && jumpTimer < 6 && jumpTimer > 0)
			{
				FALLING = false;
				JUMP -= 1;
				velocity.y = formula("shorthop") * -1;
				jumpTimer = 0;
				
            }
		}
		else{
			if (justPressed('jump'))
			{
				FALLING = false;
				JUMP -= 1;
				if(JUMP > -1)
					velocity.y = formula("fullhop") * -1;
        	}
		}
		// Reset
        if((JUMP == 0 || JUMP != maximumAirJump) && isTouching(DOWN))
            JUMP = maximumAirJump;
		if (velocity.y > 0)
			FALLING = true;
		if(FALLING)
			acceleration.y = formula('fall');
            
	}
	public function addAndCheck_Moves(name:String, input:Bool){
		moveSet.set(name,function(){
			if(input){
				animation.play(name.toLowerCase());
				switch(name){
					case 'jab':
						
					case 'forward_tilt':
						
					case 'up_tilt':
						
					case 'down_tilt':
						
					default: //idle
						
				}
			}
		});
	}

    public function setMoves(){
		addAndCheck_Moves('jab', STILL && justPressed('attack'));
		addAndCheck_Moves('forward_tilt', !STILL && justPressed('attack'));
		addAndCheck_Moves('down_tilt', justPressed('crouch') && justPressed('attack'));
		addAndCheck_Moves('up_tilt', justPressed('jump') && justPressed('attack'));

		for(i in moveSet.keyValueIterator()) i.value();
    }
	private function justPressed(str:String,anypressed:Bool = false):Bool{
		if(anypressed)
			return FlxG.keys.anyPressed([KeyBinds.Keys.get('${str.toUpperCase()}_PLAYER${playerId}')]);
		else
			return FlxG.keys.anyJustPressed([KeyBinds.Keys.get('${str.toUpperCase()}_PLAYER${playerId}')]);
	}
	private function justReleased(str:String):Bool return FlxG.keys.anyJustReleased([KeyBinds.Keys.get('${str.toUpperCase()}_PLAYER${playerId}')]);	
}