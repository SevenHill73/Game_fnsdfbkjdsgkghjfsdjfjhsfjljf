package;
import openfl.utils.Assets;
import haxe.Json;
import lime.app.Event;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import tjson.TJSON as Json;
using flixel.util.FlxSpriteUtil;
class FighterBasic extends FlxSprite{
    public var moveSet:Map<String,Void->Void> = new Map();

    // Basic Properties
	public var WALKING_SPEED:Float = 1;
	public var RUNNING_SPEED:Float = 1;
	public var FALLING_SPEED:Float = 1;
	public var JUMP_HEIGHT:Float = 1;

    public var hitboxes:Hitbox;

    // Status
	public var FALLING:Bool = true;
	public var RUNNING:Bool = false;
	public var STILL:Bool = true; 
	public var JUMP:Int = 2;
	public var AIRBORN:Bool =  true;

    //Double Jump
	var maximumAirJump = 1;

	public var characterId:Int = 0;

    public var animOffset = {
        //BASIC MOVES
        jab:[0,0],
        down_tilt:[0,0],
        forward_tilt:[0,0],
        up_tilt:[0,0],
        idle:[0,0]
    };

    public function new(characterId:Int)
    {
        super();
        this.characterId = characterId;
        JUMP = maximumAirJump + 1;
        loadFighterGraphic(characterId);
        loadFighterData(characterId);
    }

    public function loadFighterGraphic(characterId:Int){
		var name = FighterState.fightersID.get(characterId);
		switch (name)
		{
			case 'PlaceHolder':
                frames = flixel.graphics.frames.FlxAtlasFrames.fromSparrow('assets/images/fighters/${name}/${name}.png','assets/images/fighters/${name}/${name}.xml');
                
		}
        if(frames != null){
			animation.addByPrefix('idle','idle',24,false);
			animation.addByPrefix('jab','jab',24,false);
		}
	}

    public function loadFighterData(characterId:Int){
		var name = FighterState.fightersID.get(characterId);
		animOffset = Json.parse(Assets.getText('assets/data/fighters/animation/${name.toLowerCase()}.json')).offset;
		
		switch (name.toLowerCase())
		{
			case 'placeholder':
                maximumAirJump = 99;
		}
	}

    public function formula(?type:String):Float
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
    override function update(elapsed:Float) {
        super.update(elapsed);
        switch(animation.name){
            case 'jab':
                offset.set(animOffset.jab[0],animOffset.jab[1]);
            case 'forward_tilt':
                offset.set(animOffset.forward_tilt[0],animOffset.forward_tilt[1]);
            case 'up_tilt':
                offset.set(animOffset.up_tilt[0],animOffset.up_tilt[1]);
            case 'down_tilt':
                offset.set(animOffset.down_tilt[0],animOffset.down_tilt[1]);
            default: //idle
                offset.set(animOffset.idle[0],animOffset.idle[1]);
        }
    }
    //ABSTRACTS
    // abstract public function move():Void;
    // abstract public function hop():Void;
}