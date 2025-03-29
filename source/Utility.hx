package;
import flixel.text.FlxText;
class Utility{
    public static function min(num:Iterable<Float>){
        var arr = Lambda.array(num);
        arr.sort(Reflect.compare);
        return arr[0];
    }
}