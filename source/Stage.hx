package;
import js.html.idb.Factory;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;

using StringTools;
class Stage extends FlxSprite{
    
    var id:String;

    //The real touchable ground
    public var ground:FlxSprite;
   
    public function new(?id:String) {
        super();
        ground = new FlxSprite().makeGraphic(500,10,FlxColor.RED);
        ground.screenCenter();
        ground.y += 100;
        ground.immovable = true;

        this.id = id;
        immovable = true;
        if(id != null)
            switch(id.toLowerCase()){
                case 'fd':
                    makeGraphic(500, 40,FlxColor.WHITE);
                    screenCenter();
                    y += 100;
            }
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        
    }
}
