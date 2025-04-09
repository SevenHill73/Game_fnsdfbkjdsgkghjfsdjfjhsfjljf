package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxExtendedMouseSprite;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import haxe.Exception;
import haxe.Json;
import openfl.utils.Assets;
enum HitBoxType{
	CIRCLE;
	SQUARE;
	TRIANGLE;
}

enum Property
{
	NO_KNOCKBACK;
	REFLECTION(dag:Int); // you'll get damaged if this hitbox hits sb.
}

class Hitbox extends FlxExtendedMouseSprite
{
	public var type:Null<String>;
	public var animName:Null<String>;
	public var ownerPlayerID:FighterBasic;
	public var curFrame:Null<Int>;
	public var pos:Array<Float> = new Array();
	public var size:Null<Float>;
	public var property:Array<String> = new Array();
	public var kbAngle:Null<Float>;


	public function new(x:Float, y:Float, animation:String = 'jab', owner:FighterBasic, type:String = 'circle', size = 24, frame = 0, property:Array<String>,
			kbAngle:Float = 0)
	{
        super();

		loadGraphic(AssetPaths.hitboxes__png, true);

		this.animation.add('circle', [0]);
		this.animation.add('square', [1]);
		this.animation.add('triangle', [2]);

		animName = animation;
		ownerPlayerID = owner;
		this.type = type;
		this.size = size;
		this.curFrame = frame;
		this.pos = [owner.x+x, owner.y+y];
		this.kbAngle = kbAngle;

		setGraphicSize(size, size);
		this.animation.play(type);
		for (i in 0...property.length)
		{
			this.property[i] = property[i];
        }
		updateHitbox();
        visible = true;
		screenCenter();

    }
    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}