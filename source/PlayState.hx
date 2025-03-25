package;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxSpriteUtil;
class PlayState extends FlxState
{
	public var stage:Stage;
	var fighter:Fighter;
	var debugText:FlxText;
	//Instance
	public static var instance:PlayState;

	public var stageID:String;
	override public function create()
	{
		FlxG.state.bgColor = FlxColor.CYAN;
		instance = new PlayState();
		super.create();
		stageID = "fd";
		debugText = new FlxText();
        debugText.color = FlxColor.BLACK;
        debugText.size = 32;
        
        debugText.y += 300;

		stage = new Stage('fd');
		//The real touchable ground
		add(stage.ground);
		add(stage);
		
		
		
 
		fighter = new Fighter("placeholder");
		fighter.screenCenter();
		fighter.y -= 50;
		add(fighter);

		add(debugText);
		instance = this;
		
	}
	public function text(...str:Dynamic) {
        debugText.text = Std.string(str);
    }
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		text(Std.int(fighter.velocity.y),Std.int(fighter.acceleration.y));
		debugText.screenCenter();
		
		
	}
}
