package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxSpriteUtil;
class PlayState extends FlxState
{
	public var stage:Stage;
	var fighter:Array<FlxSprite> = new Array();

	var gameCam:FlxCamera;
	var line:FlxSprite;

	//Instance
	public static var instance:PlayState;

	public static var totalPlayer:Int = 0;

	public var stageID:String;

	var debugText:FlxText;

	//A sprite that is used to center the gameCam
	var camCenter:FlxSprite;
	override public function create()
	{
		debugText = new FlxText(); //useful:)

		super.create();
		gameCam = FlxG.camera;

		line = new FlxSprite();
		line.makeGraphic(FlxG.width,FlxG.height,0,true);
		add(line);

		FlxG.state.bgColor = FlxColor.CYAN;

		gameCam.zoom = 1.2;

		stage = new Stage('fd');
		instance = new PlayState();
		stageID = "fd";

		camCenter = new FlxSprite().makeGraphic(10,10);
		camCenter.alpha = 1;
		
		
		//The real touchable ground(Ground hitbox)
		add(stage.ground);
		add(stage);
 
		for(i in 0...totalPlayer - 1){
			fighter[i] = new Fighter(FighterState.selectedFighters[i], i+1);
			fighter[i].screenCenter();
			fighter[i].y -= 50;
			add(fighter[i]);
		}

		for (i in stage.blastzone){
			add(i);
		}
		instance = this;
		add(debugText);
		add(camCenter);

		gameCam.follow(camCenter);
		gameCam.setScrollBounds(0,FlxG.width,0,FlxG.height);
	}
	var tmp:Array<Float> = new Array();
	var tmp2:Array<Float> = new Array();
	var tmpList:List<Float>;
	var tmp2List:List<Float>;
	function gameCameraFollow(){
		//The Game Camera should be centered on the players.
		/*In order to do that: 
		calculate the midpoint of the distance of 2 players who are the closest to the 2 width of the blastzone.
		
		maybe there is a better way to centered the camera on the players but idrk how to do it.
		*/

		//Not Optimal
		for(i in 0...totalPlayer - 1){
			tmp[i] = Math.abs(stage.blastzone[0].x - fighter[i].x);
			tmp2[i] = Math.abs(stage.blastzone[1].x - fighter[i].x);
		}
		//idk why but Array.indexof() does not work so I used lambda
		tmpList = Lambda.list(tmp);
		tmp2List = Lambda.list(tmp2);
		var a = Lambda.indexOf(tmpList,Utility.min(tmpList));
		var b = Lambda.indexOf(tmp2List,Utility.min(tmp2List));

		FlxSpriteUtil.fill(line,0);
		camCenter.setPosition((fighter[a].x + fighter[b].x)/2,(fighter[a].y + fighter[b].y)/2 - 30);
		FlxSpriteUtil.drawLine(line,fighter[a].x,fighter[a].y,fighter[b].x,fighter[b].y,{color:FlxColor.BROWN,thickness:3});
		
	}
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		gameCameraFollow();
	}
	function print(...str:Dynamic){
		debugText.text = Std.string(str);
	}
}
