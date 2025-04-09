package;
import openfl.utils.Assets;
import flixel.text.FlxText;
import tjson.TJSON as Json;

class Utility{
    public static function min(num:Iterable<Float>)
    {
        var arr = Lambda.array(num);
        arr.sort(Reflect.compare);
        return arr[0];
    }
}