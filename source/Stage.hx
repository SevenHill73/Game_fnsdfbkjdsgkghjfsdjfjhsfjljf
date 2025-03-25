package;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;

using StringTools;
class Stage extends FlxSprite{
    
    var id:String;
    public function new(?id:String) {
        super();
        this.id = id;
        immovable = true;
        if(id != null)
            switch(id.toLowerCase()){
                case 'fd':
                    makeGraphic(500, 40,FlxColor.WHITE);
                    screenCenter();
                    y += 100;
                    //FlxSpriteUtil.drawLine(this);
            }
        
    }
}
