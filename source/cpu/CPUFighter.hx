package cpu;
import goap.Action;
import goap.ActionPlanner;
import goap.ActionPlanner;
import cpu.State;
class CPUFighter{
    public function new() {
        var planner: ActionPlanner<Moving> = new ActionPlanner();
        planner.setActions([
            new Walk(),
            new Jump()
        ]);

        var initialState:Moving = 0;
        var goalState:Moving = WALK;

        var actionPlan:ActionPlan<Moving> = planner.getPlan(initialState, goalState);
        if (actionPlan.result = Solved)
        {
            
        }
    }
}

class Walk extends Action<Moving> {

    public function new() {
        preconditions = !AIRBORN;
        effectSet = WALKED;
        cost = 0;
    }
}
class Jump extends Action<Moving>{
    public function new() {
        effectSet = JUMPED;
        cost = 0;
    }
}