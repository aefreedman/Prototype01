VAR kick_attempts = 0
VAR debug = true
VAR fuel = 1
VAR credits = 10
VAR fuel_price = 5 // price in credits

{debug:
    DEBUG MODE
    -> ship_main
    - else:
    -> intro.not_working
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
    -> ship_main
- else:
    You turn the knob. It does absolutely nothing. -> not_working
}

= working
<> and turns on. You can finally get to work! 
-> ship_main
  
 
=== ship_main

Where should you go?

+ [Home] -> go_home
+ [Engine room] -> engine_room
+ [Check the panel] -> check_panel
+ [Station] -> station_01
* ->ending

= go_home
You can't go home.
+ -> ship_main

= engine_room

Nothing to see here.

+ -> ship_main
  
= check_panel
You check the panel. It's showing a {~red|blue|yellow|green} dot in the {~first|second|third|fourth} quadrant. What does this mean?

+ You're not sure. You decide to do something else.
    -> ship_main
+ [Check again] -> check_panel

=== station_01

At the station.

+ [Buy fuel ({fuel_price} credits, have {credits})] {buy_fuel()}
    -> station_01
+ [To work] -> ship_main
* ->ending

=== function buy_fuel() ===
{ credits - fuel_price >= 0:

    ~ fuel += 1
    ~ credits -= fuel_price
    
    You have {fuel} fuel and {credits} credits. 
    
 - else:
    You don't have enough credits.
}


=== alter(ref var, val) ===
    ~ var = var + val



=== ending
- End.
-> END
