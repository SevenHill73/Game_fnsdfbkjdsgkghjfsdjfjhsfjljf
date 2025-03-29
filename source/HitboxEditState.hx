package;
import Hitbox.HitBoxType;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxInputText;
class HitboxEditState extends flixel.FlxState {
    var switchFighter:FlxButton;
    var currentFighter:Int = 0;
    var fighter:Fighter;
    var hitboxCreate:FlxButton;
    var hitboxTypeInput:FlxInputText;
    var InputHint:FlxText;
    var selectingHitbox:Bool = false;
    override function create() {
        super.create();

        FlxG.state.bgColor = flixel.util.FlxColor.CYAN;

        hitboxTypeInput = new FlxInputText();
        hitboxTypeInput.background = true;
        hitboxTypeInput.caretColor = flixel.util.FlxColor.RED;
        hitboxTypeInput.size = 48;
        hitboxTypeInput.editable = false;
        hitboxTypeInput.visible = false;


        InputHint = new FlxText(0,0,-1,'Type The Type of the HitBox U Want');
        InputHint.screenCenter();
        InputHint.y += 50;
        InputHint.color = flixel.util.FlxColor.RED;
        InputHint.visible = false;

        switchFighter = new FlxButton(0,0,'Switch Fighter',switchfighter);

        hitboxCreate = new FlxButton(0,50,'Create A Hitbox',createHitbox);

        fighter = new Fighter(currentFighter,0);
        fighter.IN_GAME = false;
        fighter.screenCenter();

        add(fighter);
        add(switchFighter);
        add(hitboxTypeInput);
        add(hitboxCreate);
        add(InputHint);
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        if(FlxG.keys.justPressed.ENTER && selectingHitbox){
            switch(hitboxTypeInput.text){
                case 'normal': 
                    add(new Hitbox(HitBoxType.NORMAL));
            };
            for(i in this){
                if(Std.isOfType(i,Hitbox))
                    cast(i,Hitbox).init();
            }
            selectingHitbox = false;
            hitboxTypeInput.editable = false;
            InputHint.visible = false;
            hitboxTypeInput.visible = false;
        }
        hitboxTypeInput.screenCenter();
        trace(FlxG.mouse.wheel);
        if(FlxG.mouse.wheel > 0){
            fighter.scale.x += 1;
            fighter.scale.y += 1;
        }
        else if(FlxG.mouse.wheel < 0){
            fighter.scale.x -= 1;
            fighter.scale.y -= 1;
        }
        if(FlxG.keys.justPressed.R){
            fighter.scale.x = 1;
            fighter.scale.y = 1;
        }
    }
    function switchfighter(){
        fighter.loadFighterGraphic(currentFighter++);
        if(currentFighter > Lambda.count(FighterState.fightersID))
             currentFighter = 0;
    }
    function createHitbox(){
        hitboxTypeInput.text = '';
        selectingHitbox = true;
        hitboxTypeInput.editable = true;
        hitboxTypeInput.visible = true;
        InputHint.visible = true;
        
            
    }
}