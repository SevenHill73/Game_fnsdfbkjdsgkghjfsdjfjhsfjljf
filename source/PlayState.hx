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
	var fighter:Fighter;

	var gameCam:FlxCamera;
	//Instance
	public static var instance:PlayState;

	var fighterGroup:FlxSpriteGroup;

	public var stageID:String;
	override public function create()
	{
		fighterGroup = new FlxSpriteGroup();	
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
 
		fighter = new Fighter(1);
		fighter.screenCenter();
		fighter.y -= 50;

		//gameCam.setPosition(100,100);

		for (i in stage.blastzone) add(i);
		add(fighter);

		instance = this;
	}
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		
	}
}
