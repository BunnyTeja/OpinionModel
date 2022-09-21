extensions [ csv ]

globals [mainlist
sub-list
turtles-list
track-list
value
temp_opn
temp_opn_2
temp_opn_3
topic_1_1_dependency
topic_1_2_dependency
topic_1_3_dependency
topic_2_1_dependency
topic_2_2_dependency
topic_2_3_dependency
topic_3_1_dependency
topic_3_2_dependency
topic_3_3_dependency


trust]
turtles-own
[
id
initial-xcor
initial-ycor
tick1-xcor
 tick1-ycor
 tick2-xcor
 tick2-ycor
 tick3-xcor
 tick3-ycor
 tick4-xcor
 tick4-ycor
 tick5-xcor
 tick5-ycor
 tick6-xcor
 tick6-ycor
 tick7-xcor
 tick7-ycor
 tick8-xcor
 tick8-ycor
 tick9-xcor
 tick9-ycor
 tick10-xcor
 tick10-ycor

 initial_opinion_1
 initial_opinion_2
 initial_opinion_3
 opinion_1
 opinion_2
 opinion_3
 topic_1
 topic_2
 topic_3
]

to reset
clear-all
file-close-all ; Close any files open from last run
reset-ticks
end


;to make-network
;;  ask turtles
;;  [
;;    create-links-with turtles-on neighbors
;;  ]
;  ask turtle 0 [
;    create-link-with turtle 1
;;    create-links-with other turtles with [color = green]
;]
;end

; procedure to write some turtle properties to a file
; Used to save the turtles created initially with random coordinates to a csv file.
;So we can use the same file every time to create turtles. So that they can be in the same posion always.
to write-turtles-to-csv
set turtles-list []
    let i 0
 repeat 1 [

  ask turtle i[
    set sub-list [ (list color size id xcor ycor shape) ] of turtle i
   ; print (sub-list)
   set turtles-list lput sub-list turtles-list
]
  set i i + 1
 ]
csv:to-file "teams.csv" turtles-list

print (turtles-list)

end

to track-cordinates-at-each-tick



  set track-list []
  set track-list lput ["id" "initial-xcor" "initial-ycor" "tick1-xcor" "tick1-ycor" "tick2-xcor" "tick2-ycor" "tick3-xcor" "tick3-ycor" "tick4-xcor" "tick4-ycor" "tick5-xcor"
  "tick5-ycor" "tick6-xcor" "tick6-ycor" "tick7-xcor" "tick7-ycor" "tick8-xcor" "tick8-ycor" "tick9-xcor" "tick9-ycor" "tick10-xcor" "tick10-ycor"] track-list

  let i 0
repeat 100 [

ask turtle i[
  set sub-list [ (list id initial-xcor initial-ycor tick1-xcor tick1-ycor tick2-xcor tick2-ycor tick3-xcor tick3-ycor tick4-xcor tick4-ycor tick5-xcor
  tick5-ycor tick6-xcor tick6-ycor tick7-xcor tick7-ycor tick8-xcor tick8-ycor tick9-xcor tick9-ycor tick10-xcor tick10-ycor) ] of turtle i

 set track-list lput sub-list track-list
]
set i i + 1
]
csv:to-file "track.csv" track-list

;  print (track-list)
end





to make-network-using-adj-matrix
file-close-all ; close all open files

if not file-exists? "adjacency_matrix.csv" [
  user-message "No file 'adjacency_matrix.csv' exists."
  stop
]

file-open "adjacency_matrix.csv" ; open the file with the links data

; We'll read all the data in a single loop
let i 0 ; initializing the row number of the adjacency matrix
let k 0 ; for testing
while [ not file-at-end? ] [
  ; here the CSV extension grabs a single line and puts the read data in a list
  let data csv:from-row file-read-line
  ; now we can use that list to create a turtle with the saved properties
  let j 0 ; cloumn number of the adjacency matrix
  repeat 100 [ ; repeating hundred times for each row i bcz we have hundred columns
    set value item j data
    if value = 1[
      if i = 0[set k k + 1
                print j] ; This statement is for testing purpose
      ask turtle i [
        create-link-with turtle j
      ]
    ]
    set j j + 1
  ]
  set i i + 1
]

 print k
file-close ; make sure to close the file
end








; procedure to read some turtle properties from a file
to read-turtles-from-csv
file-close-all ; close all open files

if not file-exists? "teams.csv" [
  user-message "No file 'teams.csv' exists."
  stop
]

file-open "teams.csv" ; open the file with the turtle data

; We'll read all the data in a single loop
  let i 0
while [ i < nb_agents ] [
  ; here the CSV extension grabs a single line and puts the read data in a list
  let data csv:from-row file-read-line
  ; now we can use that list to create a turtle with the saved properties
  create-turtles 1 [
    set color item 0 data
    set size  item 1 data
    set id item 2 data
;      set xcor random-xcor
;      set ycor random-ycor
    set xcor item 3 data
    set ycor item 4 data
    set shape item 5 data
    set opinion_1 item 6 data
    set opinion_2 item 7 data
    set opinion_3 item 8 data
    set topic_1 item 9 data
    set topic_2 item 10 data
    set topic_3 item 11 data
  ]
    set i i + 1
]
 ;if links?
  ;[make-network-using-adj-matrix]

file-close ; make sure to close the file
end


to go
let tick-count  0
repeat 3[

file-close-all ; close all open files

if not file-exists? "adjacency_matrix.csv" [
  user-message "No file 'adjacency_matrix.csv' exists."
  stop
]

file-open "topic_dependency_adjacency_matrix.csv" ; open the file with the links data

;if not file-exists? "topic_dependency_adjacency_matrix.csv" [
;  user-message "No file 'topic_dependency_adjacency_matrix.csv' exists."
;  stop
;]
;
;file-open "adjacency_matrix.csv" ; open the file with the links data

; We'll read all the data in a single loop
let i 0 ; initializing the row number of the adjacency matrix
;let count-agents nb-basic-agents + nb-information-diss-agents + nb-physical-event-agents + nb-live-agents + nb-spokesperson-agents + nb-flow-manipulator-agents

while [ i < nb_agents ] [
    ;ask turtle i [set in-trust []]
  ; here the CSV extension grabs a single line and puts the read data in a list
  let data csv:from-row file-read-line
set topic_1_1_dependency item 0 data
      set topic_1_2_dependency item 1 data
      set topic_1_3_dependency item 2 data
    set topic_2_1_dependency item 3 data
      set topic_2_2_dependency item 4 data
      set topic_2_3_dependency item 5 data
    set topic_3_1_dependency item 6 data
      set topic_3_2_dependency item 7 data
      set topic_3_3_dependency item 8 data
      ;print topic_1_1_dependency
;print topic_1_2_dependency
;print topic_1_3_dependency
;print topic_2_1_dependency
;print topic_2_2_dependency
;print topic_2_3_dependency
;print topic_3_1_dependency
;print topic_3_2_dependency
;print topic_3_3_dependency
;        print topic_1_dependency
;        print topic_2_dependency
;        print topic_3_dependency
  ; now we can use that list to create a turtle with the saved properties
  let j 0 ; cloumn number of the adjacency matrix
  let k 0
  let sumop 0
  let sumop_2 0
  let sumop_3 0
  repeat nb_agents [ ; repeating hundred times for each row i bcz we have hundred columns






        (ifelse

          i = 0 and j = 1
        [set trust Trust-0-1]

          i = 0 and j = 2
        [set trust Trust-0-2]

        i = 1 and j = 0
        [set trust Trust-1-0]

        i = 1 and j = 2
        [set trust Trust-1-2]

        i = 2 and j = 0
        [set trust Trust-2-0]

        i = 2 and j = 1
        [set trust Trust-2-1]


; elsecommands
[

       set trust 0

])


   ; print trust

   ; if trust = 1[

        ask turtle j[
        set temp_opn  opinion_1
        set temp_opn_2  opinion_2
        set temp_opn_3  opinion_3
        ]
      ;let sumop 0
      ask turtle i [

          ;let opinion_tick_1  word "Opinion_at_tick"i


          set sumop sumop + (trust * (opinion_1 - temp_opn)) + (topic_1_1_dependency * (opinion_1 - temp_opn)) + (topic_1_2_dependency * (opinion_2 - temp_opn_2))
          + (topic_1_3_dependency * (opinion_3 - temp_opn_3))

          set sumop_2 sumop_2 + (trust * (opinion_2 - temp_opn_2)) + (topic_2_1_dependency * (opinion_1 - temp_opn))
          + (topic_2_2_dependency * (opinion_2 - temp_opn_2)) + (topic_2_3_dependency * (opinion_3 - temp_opn_3))

          set sumop_3 sumop_3 + (trust * (opinion_3 - temp_opn_3)) + (topic_3_1_dependency * (opinion_1 - temp_opn))
          + (topic_3_2_dependency * (opinion_2 - temp_opn_2)) + (topic_3_3_dependency * (opinion_3 - temp_opn_3))

          ;set sumop sumop

          if j = nb_agents - 1[
          let opattick word "opinion_at_tick" i
              set opinion_1 opinion_1 + sumop / nb_agents
            set opinion_2 opinion_2 + sumop_2 / nb_agents
            set opinion_3 opinion_2 + sumop_3 / nb_agents
              set opattick opinion_1 + sumop / nb_agents
            print id
         ; print sumop
          print  opattick
          print  opinion_2
          print  opinion_3
          ]


      ]




     ; ]
;   if value = 0[ask turtle i [set out-trust? lput value out-trust?]]
    set j j + 1
  ]

  set i i + 1
]

;   print k
file-close ; make sure to close the file
    tick
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
389
49
681
342
-1
-1
8.61
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
102
228
165
261
NIL
reset
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
77
133
188
166
Create Turtles
read-turtles-from-csv
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
102
178
165
211
NIL
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
737
27
1137
200
opinion1plot
ticks
opinion_1
0.0
10.0
-10.0
10.0
true
false
"" ""
PENS
"pen-0" 1.0 0 -7500403 true "" "plot [opinion_1] of turtle 0"
"pen-1" 1.0 0 -2674135 true "" "plot [opinion_1] of turtle 1"
"pen-2" 1.0 0 -955883 true "" "plot [opinion_1] of turtle 2"
"pen-3" 1.0 0 -6459832 true "" "plot [opinion_1] of turtle 3"
"pen-4" 1.0 0 -1184463 true "" "plot [opinion_1] of turtle 4"
"pen-5" 1.0 0 -10899396 true "" "plot [opinion_1] of turtle 5"
"pen-6" 1.0 0 -13840069 true "" "plot [opinion_1] of turtle 6"
"pen-7" 1.0 0 -14835848 true "" "plot [opinion_1] of turtle 7"
"pen-8" 1.0 0 -11221820 true "" "plot [opinion_1] of turtle 8"
"pen-9" 1.0 0 -13791810 true "" "plot [opinion_1] of turtle 9"
"pen-10" 1.0 0 -13345367 true "" "plot [opinion_1] of turtle 10"

PLOT
737
233
1136
407
OPinion2Plot
ticks
Opinion_2
0.0
10.0
-10.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -7858858 true "" "plot [Opinion_2] of turtle 0"
"pen-1" 1.0 0 -7500403 true "" "plot [Opinion_2] of turtle 1"
"pen-2" 1.0 0 -2674135 true "" "plot [Opinion_2] of turtle 2"
"pen-3" 1.0 0 -955883 true "" "plot [Opinion_2] of turtle 3"
"pen-4" 1.0 0 -6459832 true "" "plot [Opinion_2] of turtle 4"
"pen-5" 1.0 0 -1184463 true "" "plot [Opinion_2] of turtle 5"
"pen-6" 1.0 0 -10899396 true "" "plot [Opinion_2] of turtle 6"
"pen-7" 1.0 0 -13840069 true "" "plot [Opinion_2] of turtle 7"
"pen-8" 1.0 0 -14835848 true "" "plot [Opinion_2] of turtle 8"
"pen-9" 1.0 0 -11221820 true "" "plot [Opinion_2] of turtle 9"

SLIDER
81
10
173
43
nb_agents
nb_agents
0
3
3.0
1
1
NIL
HORIZONTAL

PLOT
738
438
1138
604
Opinion3plot
ticks
Opinion_3
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot [Opinion_3] of turtle 0"
"pen-1" 1.0 0 -7500403 true "" "plot [Opinion_3] of turtle 1"
"pen-2" 1.0 0 -2674135 true "" "plot [Opinion_3] of turtle 2"
"pen-3" 1.0 0 -955883 true "" "plot [Opinion_3] of turtle 3"
"pen-4" 1.0 0 -6459832 true "" "plot [Opinion_3] of turtle 4"
"pen-5" 1.0 0 -1184463 true "" "plot [Opinion_3] of turtle 5"
"pen-6" 1.0 0 -10899396 true "" "plot [Opinion_3] of turtle 6"
"pen-7" 1.0 0 -13840069 true "" "plot [Opinion_3] of turtle 7"
"pen-8" 1.0 0 -14835848 true "" "plot [Opinion_3] of turtle 8"
"pen-9" 1.0 0 -11221820 true "" "plot [Opinion_3] of turtle 9"

PLOT
740
629
1136
779
eff
ticks
nb_agents
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot [opinion_1] of turtle 1"
"pen-1" 1.0 0 -7500403 true "" "plot [opinion_2] of turtle 1"
"pen-2" 1.0 0 -2674135 true "" "plot [opinion_3] of turtle 1"

SLIDER
0
49
92
82
Trust-0-1
Trust-0-1
-1
1
1.0
0.1
1
NIL
HORIZONTAL

SLIDER
94
50
186
83
Trust-0-2
Trust-0-2
-1
1
0.0
0.1
1
NIL
HORIZONTAL

SLIDER
197
49
289
82
trust-1-0
trust-1-0
-1
1
1.0
0.1
1
NIL
HORIZONTAL

SLIDER
0
91
92
124
Trust-1-2
Trust-1-2
-1
1
1.0
0.1
1
NIL
HORIZONTAL

SLIDER
92
91
184
124
Trust-2-0
Trust-2-0
0
10
1.0
1
1
NIL
HORIZONTAL

SLIDER
195
91
287
124
Trust-2-1
Trust-2-1
0
10
0.0
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

We are trying to create agents in two teams red and blue and finding out how the information spread is happening in the world.

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

1.setup

   	 When you click on setup button it clears all the turtles in the world. 
   	 Closes all the open files and reset the ticks.

2.links?

  	When you make the links on before creating the turtles. It will create the turtles with links using the given adjacency matrix. 

3.Create turtles

  	 Turtles will be created using a csf file by the given id, size, color and coordinates

4.go

	 The coordinates of all the turtles changes by the given formula and we will repeat it for 10 times(ticks)

5.Track coordinates at each tick in csv file

	 It creates a csv file with id initial coordiante values and the new values at each tick for all the turtles.

## THINGS TO NOTICE

	If you want a new start click on setup.

	If you want to create turtles with links make sure you have turned on the links? switch 
	
	

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

	We are using csv extension. As we are trying to create turtles based on the information in a csv file.
	
	

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
