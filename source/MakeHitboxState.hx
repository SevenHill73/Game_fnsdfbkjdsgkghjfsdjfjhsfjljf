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
    var hitBoxes:List<Hitbox>;
    override function create() {
        super.create();
        FlxG.state.bgColor = FlxColor.CYAN;

        createHitbox = new FlxButton(0,600,'Create A Hitbx for this frame',createAHitbox);
        createHitbox.scale.y = 1.5;
        createHitbox.updateHitbox();

        fighter = new Fighter(0,0);
        fighter.screenCenter();
        fighter.IN_GAME = false;
        fighter.animation.play('idle');
        fighter.animation.pause();
        fighter.animation.curAnim.curFrame = 0;

        curframe = new FlxText(0,300,'hi');
        curframe.color = FlxColor.BLACK;

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
            fighter.animation.curAnim.curFrame = 0;
        };

        add(fighterAnimationSelection);
        add(fighterSelection);
        add(fighter);
        add(curframe);
        add(createHitbox);
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        curframe.screenCenter(Y);
        curframe.text = 'CurFrame: ${Std.string(fighter.animation.curAnim.curFrame)}\nTotal Frame: ${Std.string(fighter.animation.curAnim.numFrames)}';
        if(FlxG.keys.justPressed.LEFT){
            if(fighter.animation.curAnim.curFrame < 0)
                fighter.animation.curAnim.curFrame = fighter.animation.curAnim.numFrames;
            else
                fighter.animation.curAnim.curFrame -= 1;
        }
        if(FlxG.keys.justPressed.RIGHT){
            if(fighter.animation.curAnim.curFrame < fighter.animation.curAnim.numFrames)
                fighter.animation.curAnim.curFrame += 1;
                
            else
                fighter.animation.curAnim.curFrame = 0;
        }
    }
    function createAHitbox(){
        hitBoxes.add(new Hitbox(null,fighter.animation.curAnim.curFrame));
        for(i in hitBoxes){
            if(Lambda.has(this.members,i))
                continue;
            else
                add(i);
        }
    }
}
#end