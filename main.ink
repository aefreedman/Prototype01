VAR kick_attempts = 0
VAR debug = true
VAR fuel = 1
VAR credits = 10
VAR fuel_price = 5 // price in credits
VAR destination = -> invalid_destination
VAR is_jumping = false
VAR strapped_in = false

{debug:
    DEBUG MODE
    -> ship_main
    - else:
    -> intro.not_working
}

=== function buy_fuel() ===
    { credits - fuel_price >= 0:

        ~ fuel += 1
        ~ credits -= fuel_price
        {describe_fuel()}
    
    - else:
        You don't have enough credits.
    }

=== function describe_fuel() ===
    You have {fuel} fuel.

=== function describe_fuel_credits() ===
    You have {fuel} fuel and {credits} credits. 

=== function alter(ref var, val) ===
    ~ var = var + val

=== intro

= not_working
    It's {|still} not {||{~fucking|freaking}} working.

    {not working:
    + [Kick the panel.] -> kick
    }
    + [Turn the knob.] -> turn
    * -> END

= kick
    ~ kick_attempts += 1
        You kick the panel. The display flickers briefly 
    { kick_attempts < 3:
        <>, and then shuts off again.
        -> not_working
    - else:
        -> working
    }

= turn
    { working:
        it works 
        -> ship_main
    - else:
        You turn the knob. It does absolutely nothing. -> not_working
    }

= working
    <> and turns on. You can finally get to work! 
    -> ship_main
  
 
=== ship_main

    + [Engine room] -> engine_room
    + [Navigation] -> navigation
    + [Jump] 
        { strapped_in:
            -> jump_sequence
        - else:
            You should probably sit down and strap in before you jump.
            -> ship_main
        }
    + { not strapped_in } [Strap in] -> strap_in

    // + [Station] -> station_01
    * -> ending

= strap_in
    You sit down in the pilot seat and buckle your six-point harness. You're ready to make the jump.
    ~ strapped_in = true
    -> ship_main

= navigation

    Navigation

    + [Plot a course] -> course_plot
    + [Check the panel] -> check_panel
    + [Back] -> ship_main

= engine_room

    Nothing to see here.

    + -> ship_main
  
= check_panel
    You check the panel. It's showing a {~red|blue|yellow|green} dot in the {~first|second|third|fourth} quadrant. What does this mean?

    + You're not sure. You decide to do something else.
        -> ship_main
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
    + [Back] -> ship_main

= go_home
    You can't go home.
    + -> ship_main
    
=== function set_destination(value)
    ~ destination = value
    Destination is now {destination}.
 
=== invalid_destination ===
    Invalid destination.
    ->ship_main

=== station_01

    At the station.
    
    { is_jumping: {use_fuel()} }
    

    + [Buy fuel ({fuel_price} credits, have {credits})] {buy_fuel()}
        -> station_01
    + [Back to the ship] -> ship_main
    * ->ending

=== function use_fuel() ===
    { fuel - 1 >= 0:
        ~ fuel -= 1
        {describe_fuel()}
        // ~ return true
    // - else:
        // ~ return false 
    }



=== ending
    - End.
-> END
