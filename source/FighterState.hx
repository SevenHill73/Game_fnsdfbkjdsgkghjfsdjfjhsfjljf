package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.ds.List;
//CHOOSE YOUR FIGHTER!
class FighterState extends FlxState {
    public static var fightersID:Map<Int, String> = [
        0 => "PlaceHolder",
        1 => "PlaceHolder",
    	2 => "PlaceHolder",
        3 => "Random",
    ];

    var fighterBlockGroup:Array<FlxButton> = new Array();

    //I don't like 2D array
    var playerGroup:List<Array<Int>> = new List();

    final maximumPlayer = 4;

    var background:FlxSprite;

    //The player who is selecting
    var _currentPlayer:Int = 1;

    var debugText:DebugText;

    var player_selecting:FlxSprite;
    override function create() {
        //FlxG.mouse.useSystemCursor = true;
        debugText = new DebugText();
        debugText.y += 300;

        super.create();

        player_selecting = new FlxSprite();
        player_selecting.frames = flixel.graphics.frames.FlxAtlasFrames.fromSparrow(AssetPaths.PlayerSelecting__png,AssetPaths.PlayerSelecting__xml);
        for (i in 1...maximumPlayer+1) 
            player_selecting.animation.addByPrefix(Std.string(i),'player${Std.string(i)}',30,false);

        background = new FlxSprite().makeGraphic(FlxG.width,FlxG.height,FlxColor.BROWN);
        add(background);
        //Turn List into Blocks
        var x = 0;
        for(i in fightersID) {
            fighterBlockGroup[x] = new FlxButton(0,0,i);
            fighterBlockGroup[x].makeGraphic(80,60);
            fighterBlockGroup[x].x = x * 100;
            add(fighterBlockGroup[x]);
            x++;
        }
        add(debugText);
        add(player_selecting);
        
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        player_selecting.animation.play(Std.string(_currentPlayer));
        player_selecting.setPosition(FlxG.mouse.x - 40,FlxG.mouse.y - 35);

        debugText.print(_currentPlayer);

        for(i in 0...fighterBlockGroup.length) {
            if (fighterBlockGroup[i].justPressed) fighterBlockClicked(fighterBlockGroup[i]);
            fighterBlockGroup[i].label.y = fighterBlockGroup[i].label.origin.y + 30;
        }
    }
    function fighterBlockClicked(button:FlxButton){
        _currentPlayer += 1;
        playerGroup.add([]);
        if(_currentPlayer > 4)
            FlxG.switchState(()->new PlayState());
    }
}