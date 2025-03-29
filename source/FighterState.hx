package;
import flixel.input.keyboard.FlxKey;
import flixel.input.FlxInput;
import flixel.system.macros.FlxMacroUtil;
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
    public static var fightersID:Map<Int, String> = [ //No Repeat Please :)
        0 => "PlaceHolder"
    ];
    public static var reversedFightersID:Map<String,Int> = new Map();

    public static var selectedFighters:Array<Int> = new Array();
    var fighterBlockGroup:Array<FlxButton> = new Array();

    //more player support in the future
    final maximumPlayer = 1;

    var background:FlxSprite;

    //The player who is selecting
    var _currentPlayer:Int = 1;

    var removePlayer:FlxButton;

    var player_selecting:FlxSprite;

    override function create() {
        
        //FlxG.mouse.useSystemCursor = true;

        super.create();

        removePlayer = new FlxButton(0,-200,'0 Players Battle',battlePlayerSet);
        removePlayer.setGraphicSize(128,64);

        player_selecting = new FlxSprite();
        player_selecting.frames = flixel.graphics.frames.FlxAtlasFrames.fromSparrow(AssetPaths.PlayerSelecting__png,AssetPaths.PlayerSelecting__xml);
        for (i in 1...maximumPlayer+1) 
            player_selecting.animation.addByPrefix(Std.string(i),'player${Std.string(i)}',30,false);

        background = new FlxSprite().makeGraphic(FlxG.width,FlxG.height,FlxColor.BROWN);
        add(background);

        //Turn Map into Blocks
        var x = 0;
        for(i in fightersID) {
            fighterBlockGroup[x] = new FlxButton(0,0,i);
            fighterBlockGroup[x].makeGraphic(80,60);
            fighterBlockGroup[x].x = x * 100;
            add(fighterBlockGroup[x]);
            x++;
        }

        add(player_selecting);

        add(removePlayer);
        

        //Adding values to the reversed fightersid map
        for(i in fightersID.keyValueIterator())
            reversedFightersID.set(i.value,i.key);
        
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        if(FlxG.keys.pressed.H&&FlxG.keys.pressed.CONTROL&&FlxG.keys.pressed.SHIFT)
            FlxG.switchState(HitboxEditState.new);
        
        player_selecting.animation.play(Std.string(_currentPlayer));
        player_selecting.setPosition(FlxG.mouse.x - 40,FlxG.mouse.y - 35);

        removePlayer.screenCenter();
        removePlayer.text = '${_currentPlayer - 1} Players Battle';

        removePlayer.label.setPosition(removePlayer.x,removePlayer.y);
        removePlayer.label.setGraphicSize(removePlayer.width,removePlayer.height);
        
        _currentPlayer > 2 ? removePlayer.visible = true : removePlayer.visible = false;

        //Get what people selected and Button Text Position Adjust
        for(i in 0...fighterBlockGroup.length){
            if(fighterBlockGroup[i].justReleased) { 
                selectedFighters[_currentPlayer-1] = reversedFightersID.get(fighterBlockGroup[i].text);
                fighterBlockClicked();
            }
            fighterBlockGroup[i].label.y = fighterBlockGroup[i].label.origin.y + 30;
        }
    }
    function battlePlayerSet(){
        PlayState.totalPlayer = _currentPlayer - 1;
        FlxG.switchState(PlayState.new);
    }
    function fighterBlockClicked(){
        _currentPlayer += 1;
        //playerGroup.add([]);
        if(_currentPlayer > maximumPlayer){
            PlayState.totalPlayer = _currentPlayer;
            FlxG.switchState(PlayState.new);
        }
    }
}