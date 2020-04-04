# Called from: moesh:tick

#---------------------------------------------------------------------------------------------------
# Purpose: Give player speed when scaffolding had a solid block under it.
#---------------------------------------------------------------------------------------------------
execute as @a[team=players] at @s anchored feet if block ~ ~-1 ~ minecraft:scaffolding unless block ~ ~-2 ~ minecraft:air run tag @s add Boost
effect give @a[team=players,tag=Boost] minecraft:speed 1 3 false
execute as @a[team=players] run tag @s remove Boost

#---------------------------------------------------------------------------------------------------
# Purpose: Handle different scaffolding configurations
#---------------------------------------------------------------------------------------------------
# Is the player in scaffolding and not sneaking? Shoot them up.
execute as @a[tag=!Levitate] at @s anchored feet if block ~ ~ ~ minecraft:scaffolding unless entity @s[scores={sneakTime=1..}] run tag @s add Levitate
execute as @a[tag=Levitate,scores={sneakTime=0}] at @s anchored feet if block ~ ~ ~ minecraft:scaffolding run effect give @s minecraft:levitation 3 23 false
# They've left scaffolding, stahp!
execute as @a[tag=Levitate] at @s anchored feet if block ~ ~ ~ minecraft:air run effect clear @s minecraft:levitation
execute as @a[tag=Levitate] at @s anchored feet if entity @s[scores={sneakTime=1..}] run effect clear @s minecraft:levitation
# Give them a cute little puff of air when they exit the scaffolding
execute as @a[tag=Levitate] at @s anchored feet if block ~ ~ ~ minecraft:air run particle minecraft:cloud ~ ~ ~ 0.5 0.1 0.5 0.1 200 force
execute as @a[tag=Levitate] at @s anchored feet if block ~ ~ ~ minecraft:air run tag @s remove Levitate

# sneakTime increments when a player is crouching (holding SHIFT), reset it after checking to see if
# player has crouched in the last tick.
scoreboard players set @a[scores={sneakTime=1..}] sneakTime 0