package;
import lime.app.Event;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;
class Fighter extends FlxSprite {
	var moveSet:Map<String,Void->Void> = new Map();
    //This is for the short hop and the full hop
	var jumpTimer:Int = 0;
	//This is for tilts/chargeable attack
	var attackTimer:Int = 0;
	//Init
	// Basic Properties
	var WALKING_SPEED:Float = 1;
	var RUNNING_SPEED:Float = 1;
	var FALLING_SPEED:Float = 1;
	var JUMP_HEIGHT:Float = 1;

    //Double Jump
	var maximumAirJump = 1;

	// Status
	var FALLING:Bool = true;
	var RUNNING:Bool = false;
	var STILL:Bool = true; 
	var JUMP:Int = 2;
	var AIRBORN:Bool =  true;

	var playerId(default,set):Int;
	var characterId:Int;

	public var IN_GAME:Bool = true;
	public function new(characterId:Int,playerId:Int)
	{
        super();
		this.characterId = characterId;
		this.playerId = playerId;

        JUMP = maximumAirJump + 1;
		loadFighterGraphic(characterId);
    }
	public function loadFighterGraphic(characterId:Int){
		var name = FighterState.fightersID.get(characterId);
		switch (name)
		{
			case 'PlaceHolder':
                makeGraphic(20,20,FlxColor.WHITE);
		}
	}
    override function update(elapsed:Float){
        super.update(elapsed);
		if(IN_GAME){
			FlxG.collide(PlayState.instance.stage.ground, this);
			AIRBORN = isTouching(DOWN) ? false : true;
			for (i in PlayState.instance.stage.blastzone) 
				if(FlxG.collide(i,this))
					kill();
				
			hop();
			move();
			setMoves();
		}
	}
    
	function formula(?type:String):Float
	{
		switch (type)
		{
			case "walk":
				return (300.0 * WALKING_SPEED) * 0.4;
			case 'fall':
				return (1000.0 * FALLING_SPEED) * 0.4;
			case 'fullhop':
				return (400 * JUMP_HEIGHT) * 0.4;
			case 'shorthop':
				return (260.0 * JUMP_HEIGHT) * 0.4;
			default: // run
				return (600.0 * RUNNING_SPEED) * 0.4;
		}
	}

	private function move()
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

	private function hop()
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
	var moveInputted = new Event<Void->Void>();
	private function newMove(name:String, input:Bool){
		moveSet.set(name,function(){
			if(input){
				switch(name){
					case 'jab':
						trace('jab');
					case 'forward_tilt':
						trace('forward_tilt');
					default:
						return;
				}
			}
		});
	}
    private function setMoves(){
		newMove('jab', STILL && justPressed('attack'));
		newMove('forward_tilt', !STILL && justPressed('attack'));

		for(i in moveSet.keyValueIterator()) i.value();
    }

	private function justPressed(str:String,anypressed:Bool = false):Bool{
		if(anypressed)
			return FlxG.keys.anyPressed([KeyBinds.Keys.get('${str.toUpperCase()}_PLAYER${playerId}')]);
		else
			return FlxG.keys.anyJustPressed([KeyBinds.Keys.get('${str.toUpperCase()}_PLAYER${playerId}')]);
	}
	private function justReleased(str:String):Bool return FlxG.keys.anyJustReleased([KeyBinds.Keys.get('${str.toUpperCase()}_PLAYER${playerId}')]);


	public function set_playerId(value:Int):Int return playerId = value;
	
}