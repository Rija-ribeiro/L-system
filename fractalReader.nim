import fractalGenerator, fractalPainter
import os, strutils, tables

const SEPARATOR = '_'
var actId = initTable[char, int]()
actId['L'] = L
actId['R'] = R
actId['M'] = M
actId['P'] = P
actId['F'] = F

proc strToSeqact(chain:string):seq[int] =
  for letter in chain:
    result.add(actId[letter])

let lines = readFile(paramStr(1)).split("\n")
var set = ActionSet(@[])
# initialise toutes les actions
for letter in lines[0]:
  assert not actId.hasKey(letter)
  actId[letter] = set.newAction()

for line in lines:
  if not (SEPARATOR in line): continue
  if '#'' in line: continue
  let id = actId[line[0]]
  let approx = strToSeqact(line.split(SEPARATOR)[1])
  let recurtion = strToSeqact(line.split(SEPARATOR)[2])
  set.setApprox(id, approx)
  set.setRecurtion(id, recurtion)
set.draw(
  actId[lines[0][0]], # le tout premier caractère est l'action à génerer
  paramStr(2).parseInt(), # le nombre de génération
  paramStr(1) & paramStr(2) # le nom de l'image
  )
