package;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;
import flixel.FlxG;
enum HitBoxType{
    NORMAL;
}
class Hitbox extends FlxSprite {
    public var IN_GAME = true;
    var draggable = true;
    public function new(HitboxType:EnumValue,size:Int = 20) {
        super();
        init(size);
    }
    public function init(size:Int = 20){
        makeGraphic(size,size,FlxColor.TRANSPARENT);
        FlxSpriteUtil.drawCircle(this,this.x,this.y,-1,{color:FlxColor.RED});
        if(IN_GAME){
            visible = false;
        }
        else{
            screenCenter();
            draggable = true;
        }
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        if(draggable){
            setPosition();
        }
    }
}