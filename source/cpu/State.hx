package cpu;

@:build(goap.macro.StateBuilder.build())
enum abstract Moving(Int) to Int
{
    var AIRBORN;
    var WALKED;
    var STILL;
    var JUMPED;
}