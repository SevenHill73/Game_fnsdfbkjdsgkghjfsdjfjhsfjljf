package;
import haxe.Exception;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;
import flixel.FlxG;
import haxe.Json;
import openfl.utils.Assets;
enum HitBoxType{
    NORMAL;
}

class Hitbox extends FlxSprite {
    var data:Dynamic;
    var fighterName:String;
    public function new(?fighterName:String,frame = 0) {
        super();
        this.fighterName = fighterName;
        try{
            data = Json.parse(Assets.getText('assets/data/fighters/hitboxes/${fighterName.toLowerCase()}.json'));
        }
        catch(e:Exception){
            trace("Failed on loading JSON");
        }
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