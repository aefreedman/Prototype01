=== station_01

    At the station.
    
    { is_jumping: {use_fuel()} }
    

    + [Buy fuel ({fuel_price} credits, have {credits})] {buy_fuel()}
        -> station_01
    + [Back to the ship] -> ship_main_corridor
    * ->ending
    
=== function buy_fuel() ===
    { credits - fuel_price >= 0:

        ~ fuel += 1
        ~ credits -= fuel_price
        {describe_fuel()}
    
    - else:
        You don't have enough credits.
    }