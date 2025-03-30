package;
#if MakeHitboxState
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.ui.StrNameLabel;
import flixel.FlxState;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.FlxG;
class MakeHitboxState extends FlxState{
    var fighter:Fighter;
    var fighterSelection:FlxUIDropDownMenu;
    var fighterAnimationSelection:FlxUIDropDownMenu;
    var curframe:FlxText;
    var createHitbox:FlxButton;
    override function create() {
        super.create();
        FlxG.state.bgColor = FlxColor.CYAN;

        createHitbox = new FlxButton(0,600,'Create A Hitbx for this frame',createAHitbox);

        fighter = new Fighter(0,0);
        fighter.screenCenter();
        fighter.IN_GAME = false;
        fighter.animation.play('idle');

        curframe = new FlxText(0,300);

        var n = 0;
        var fighterArray:Array<StrNameLabel> = new Array();
        for(i in FighterState.fightersID.keyValueIterator()){
            fighterArray[n] = new StrNameLabel(i.value,i.value);
            n++;
        }
        fighterSelection = new FlxUIDropDownMenu(0,0,fighterArray);
        fighterSelection.callback = (str:String) -> {
            fighter.loadFighterGraphic(Std.parseInt(str));
        };

        var fighterAnimationArray:Array<StrNameLabel> = new Array();
        n = 0;
        for(i in fighter.animation.getNameList()){
            fighterAnimationArray[n] = new StrNameLabel(i,i);
            n++;
        }
        fighterAnimationSelection = new FlxUIDropDownMenu(0,100,fighterAnimationArray);
        fighterAnimationSelection.callback = (str:String) -> {
            fighter.animation.play(str);
            fighter.animation.pause();
            fighter.animation.frameIndex = 0;
        };


        add(fighterAnimationSelection);
        add(fighterSelection);
        add(fighter);
        add(curframe);
        add(createHitbox);
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        curframe.text = Std.string(fighter.animation.frameIndex);
        if(FlxG.keys.justPressed.LEFT){
            fighter.animation.frameIndex -= 1;
            if(fighter.animation.frameIndex < 1)
                fighter.animation.frameIndex = fighter.animation.curAnim.numFrames;
        }
        else if(FlxG.keys.justPressed.RIGHT){
            fighter.animation.frameIndex += 1;
            if(fighter.animation.frameIndex > fighter.animation.curAnim.numFrames)
                fighter.animation.frameIndex = 1;
        }
    }
    function createAHitbox(){
        
    }
}
#end