package;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;
import flixel.FlxG;
import haxe.Json;
import openfl.utils.Assets;
enum HitBoxType{
    NORMAL;
}
var data:Dynamic;
class Hitbox extends FlxSprite {
    public function new(im:String) {
        super();
        if(data != null)
            data = Json.parse(Assets.getText('assets/data/fighters/hitboxes/${im}'));
        visible = true;
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        FlxSpriteUtil.fill(this,0);
        FlxSpriteUtil.drawCircle(this,this.x,this.y,-1,FlxColor.RED);
    }
    public function useHitbox(){

    }
}