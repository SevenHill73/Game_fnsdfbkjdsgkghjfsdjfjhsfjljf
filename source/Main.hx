package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		//FlxG.stage.quality = openfl.display.StageQuality.BEST;
		addChild(new FlxGame(0, 0, FighterState));
	}
}
