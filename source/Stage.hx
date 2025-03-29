package;
import flixel.group.FlxSpriteGroup;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
class Stage extends FlxSprite{
    
    var id:String;

    //The real touchable ground
    public var ground:FlxSprite;

    //In case you don't know: Blastzone is where players die off-screen
    public var blastzone:Array<FlxSprite>;

    public function new(?id:String) {
        super();

        ground = new FlxSprite().makeGraphic(500,10,FlxColor.RED);
        ground.immovable = true;

        //sorry im too stupid
        blastzone = [
            new FlxSprite(0,0).makeGraphic(10,FlxG.height,FlxColor.RED),
            new FlxSprite(FlxG.width - 15,0).makeGraphic(10,FlxG.height,FlxColor.RED),
            new FlxSprite(0,0).makeGraphic(FlxG.width,10,FlxColor.RED),
            new FlxSprite(0,FlxG.height - 15).makeGraphic(FlxG.width,10,FlxColor.RED)
        ];
        for(i in blastzone) i.immovable = true;

        this.id = id;
        immovable = true;
        if(id != null)
            switch(id.toLowerCase()){
                case 'fd':
                    makeGraphic(500, 40,FlxColor.WHITE);
                    screenCenter();
                    y += 100;
                    ground.screenCenter(X);
                    ground.y = y;
            }
    }
    override function update(elapsed:Float) {
        super.update(elapsed);

    }
}
