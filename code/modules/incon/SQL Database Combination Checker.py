from itertools import product
import sqlite3

conn = sqlite3.connect('InconFlavortextDB.db')

#possibleStates = ["peeaccident = 1",
#                  "poopaccident = 1",
#                  "peefirstwarning = 1",
#                  "peesecondwarning = 1",
#                  "peefinalwarning = 1",
#                  "poofirstwarning = 1",
#                  "poosecondwarning = 1",
#                  "poofinalwarning = 1"]

possibleStates = ["peeaccident = 1",
                  "poopaccident = 1",
                  "peefirstwarning = 1",
                  "peesecondwarning = 1",
                  "poofirstwarning = 1",
                  "poosecondwarning = 1"]





taurStates = ["istaur = 1",
              "isnottaur = 1"]

tailStates = ["hastail = 1",
              "notail = 1"]

purposeState = ["onpurpose = 1",
                "notonpurpose = 1"]

pottyState = ["1=1",
              "usingpotty = 1",
              "usingtoilet = 1"]

allOfTheStates = list(product(possibleStates, taurStates, tailStates, purposeState, pottyState))

for state in allOfTheStates:
    #print(state)
    #statestring = f"SELECT * FROM InconFlavortextDB WHERE ({state[0]} AND {state[1]} AND {state[2]} AND {state[3]} AND {state[4]})"
    statestring = f"SELECT * FROM InconFlavortextDB WHERE ({state[0]} AND {state[1]} AND {state[2]} AND {state[3]})"
    #statestring = "SELECT * FROM InconFlavortextDB WHERE (peeaccident = 1)"
    print(statestring)
    cursor = conn.execute(statestring)

    print(len(cursor.fetchall()))
    
print(len(allOfTheStates))
