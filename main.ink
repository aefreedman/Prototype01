INCLUDE Station01.ink
INCLUDE Asteroid01.ink
INCLUDE Ship.ink

VAR kick_attempts = 0
VAR debug = true
VAR fuel = 1
VAR credits = 10
VAR fuel_price = 5 // price in credits
VAR destination = -> invalid_destination
VAR is_jumping = false

CONST STATION = 1

{debug:
    DEBUG MODE
    -> ship_main_corridor
    - else:
    -> intro.not_working
}

=== function describe_fuel() ===
    You have {fuel} fuel.

=== function describe_fuel_credits() ===
    You have {fuel} fuel and {credits} credits. 
    
=== function describe_destination(value)
    {
        - STATION:
        ~ return "Space Station"
        - else:
        ~ return "(no destination)"
    }

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
        -> ship_main_corridor
    - else:
        You turn the knob. It does absolutely nothing. -> not_working
    }

= working
    <> and turns on. You can finally get to work! 
    -> ship_main_corridor
  
=== ending
    - End.
-> END
