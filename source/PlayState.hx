package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
class PlayState extends FlxState
{
	public var stage:Stage;
	var fighter:Array<FlxSprite> = new Array();

	var gameCam:FlxCamera;

	//Instance
	public static var instance:PlayState;

	public static var totalPlayer:Int = 0;

	public var stageID:String;
	override public function create()
	{
		gameCam = FlxG.camera;
		gameCam.zoom = 1.2;

		stage = new Stage('fd');
		FlxG.state.bgColor = FlxColor.CYAN;
		instance = new PlayState();
		super.create();
		stageID = "fd";

		
		//The real touchable ground
		
		add(stage.ground);
		add(stage);
 
		for(i in 0...totalPlayer){
			fighter[i] = new Fighter(1, i);
			fighter[i].screenCenter();
			fighter[i].y -= 50;
			add(fighter[i]);
			trace(i);
		}

		//gameCam.setPosition(100,100);

		for (i in stage.blastzone) add(i);
		instance = this;
	}
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
