type
  #[
  Les actions sont des définitions de dessin.
  Elles sont constitué de leurs définition par récurence et de leur approximation.
  On utilise ici des seq de int et non des seq de Action car on fait référence à l'index de l'action dans un ActionSet.
  ]#
  Action* = ref object
    recurtion:seq[int]
    approx:seq[int]
  # Un action set est simplement une un espace dans lequel on va pouvoir définire des actions et les lier entre elles.
  ActionSet* = seq[Action]

func newAction*(aSet:var ActionSet):int =
  aSet.add(new Action)
  return len(aSet)-1

func setRecurtion*(aSet:var ActionSet, i:int, act:seq[int]) =
  aSet[i].recurtion = act

func setApprox*(aSet:var ActionSet, i:int, act:seq[int]) =
  aSet[i].approx = act

iterator generate*(aSet:var ActionSet, i0, g0:int):int {.closure.} =
  if i0<0:
    yield i0
  elif g0==0:
    for i1 in aSet[i0].approx:
      yield i1
  else:
    let g1 = g0-1
    for i1 in aSet[i0].recurtion:
      for i2 in generate(aSet, i1, g1):
        yield i2

