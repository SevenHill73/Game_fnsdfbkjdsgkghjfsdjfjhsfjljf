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

class Hitbox extends FlxSprite {
    var data:Dynamic;
    var fighterName:String;
    public function new(?fighterName:String,frame = 0) {
        super();
        this.fighterName = fighterName;
        if(fighterName != null && Assets.exists('assets/data/fighters/hitboxes/${fighterName.toLowerCase()}.json'))
            data = Json.parse(Assets.getText('assets/data/fighters/hitboxes/${fighterName.toLowerCase()}.json'));
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