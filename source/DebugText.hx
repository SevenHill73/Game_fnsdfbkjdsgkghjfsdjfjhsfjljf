package;
import flixel.text.FlxText;
class DebugText extends FlxText{
    public function new(?x:Float,?y:Float) {
        super(x,y);
        color = flixel.util.FlxColor.BLACK;
        size = 32;
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        screenCenter();
    }
    public inline function print(...str:Dynamic) {
        text = Std.string(str);
    }
}