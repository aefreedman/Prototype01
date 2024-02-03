CONST SHIP_NAME = "Brigadiero"

=== ship_main_corridor
You're standing in the main corridor of the {SHIP_NAME}.
{ship_main_corridor == 1:<> You're exhausted from your previous investigation, but you're glad to be back on your ship.} 

    + [Go to the engine room] -> engine_room
    + [Go to the bridge] -> bridge
    + [Go to the cargo hold] You walk to the cargo hold. -> cargo_hold

    * -> ending

=== engine_room ===
You're inside of the engine room.

    + [Leave the engine room] You exit {&|back} through the bulkhead door to the main corridor. -> ship_main_corridor
    
=== cargo_hold ===
You're standing inside the cargo hold of the {SHIP_NAME}. It can't hold much, and you've currently got nothing of interest stored in your hold.

    + [Leave the cargo hold] You step back out of the cargo hold. -> ship_main_corridor
    
=== bridge ===
    
    + [Sit down] You sit down in the pilot's seat.
    
    - (sitting)
        ++ [Navigation] -> navigation
        ++ [Strap in]
        You sit down in the pilot seat and buckle your six-point harness. You're ready to make the jump.
        
        - - (strapped_in)
        +++ {strapped_in} [Jump] 
            -> jump_sequence
        
= navigation

    Navigation

    + [Plot a course] -> course_plot
    + [Check the panel] -> check_panel
    + [Back] -> ship_main_corridor
    
= check_panel
    You check the panel. It's showing a {~red|blue|yellow|green} dot in the {~first|second|third|fourth} quadrant. What does this mean?

    + You're not sure. You decide to do something else.
        -> ship_main_corridor
    + [Check again] -> check_panel    
    
=== jump_sequence ===
    ... Jumping ...
    ~ is_jumping = true
    -> destination

=== course_plot

    Where to go?

    + [Home] -> go_home
    + [Set destination Station 1]  {set_destination(->station_01)} 
        -> course_plot
    + [Back] -> ship_main_corridor

= go_home
    You can't go home.
    + -> ship_main_corridor
    
=== function set_destination(-> value)
    ~ destination = value
    Destination is now {describe_destination(STATION)}.
    
 
=== invalid_destination ===
    Invalid destination.
    ->ship_main_corridor



=== function use_fuel() ===
    { fuel - 1 >= 0:
        ~ fuel -= 1
        {describe_fuel()}
        // ~ return true
    // - else:
        // ~ return false 
    }