import fractalGenerator
import pixie, strutils

const
  pointMaxAxis = 4
  L* = -1 # turn on left
  R* = -2 # turn on right
  M* = -3 # move without draw
  P* = -4 # draw a pixel
  F* = -5 # draw a move

type Point = object
  x:int
  y:int
  d:int

func turnLeft(point: var Point) =
  if point.d==0:
    point.d = pointMaxAxis
  point.d -= 1

func turnRight(point: var Point) =
  point.d += 1
  if point.d==pointMaxAxis:
    point.d = 0

func move(point: var Point) =
  case point.d:
    of 0:
      point.x -= 1
    of 1:
      point.y -= 1
    of 2:
      point.x += 1
    else:
      point.y += 1

proc teint(t: float):Color =
  # return color(1.0, 1.0, 1.0)

  proc clamp(x: float): float =
    if x < 0: return 0
    elif x > 1: return 1
    else: return x

  let tt = (t mod 1.0) * 6.0

  let r = clamp(abs(tt - 3.0) - 1.0)
  let g = clamp(2.0 - abs(tt - 2.0))
  let b = clamp(2.0 - abs(tt - 4.0))

  return color(r, g, b)

func drawPixel(surf:var Image, point:var Point, p:float) = surf.setColor(point.x, point.y, teint(p))

func execAction(surf:var Image, point:var Point, act:int, draw:bool, p:float) =
  case act:
    of L:
      turnLeft(point)
    of R:
      turnRight(point)
    of M:
      move(point)
    of P:
      if draw:
        drawPixel(surf, point, p)
    of F:
      if draw:
        drawPixel(surf, point, p)
      move(point)
    else:
      discard

func canvaLimits(path:seq[int]):(int, int, int, int) =
  var uselessSurf = newImage(1, 1)
  var xMin:int
  var yMin:int
  var xMax:int
  var yMax:int
  var p = Point(x:0, y:0, d:0)
  for act in path:
    uselessSurf.execAction(p, act, false, 0.0)
    xMin = min(xMin, p.x)
    yMin = min(yMin, p.y)
    xMax = max(xMax, p.x)
    yMax = max(yMax, p.y)
  return (xMin-1, yMin-1, xMax+2, yMax+2)

proc draw*(aSet:var ActionSet, act, g:int, name:string) =
  echo "génération de la fractale..."
  var path:seq[int]
  for a in aSet.generate(act, g):
    path.add(a)
  echo "initialisation grafique..."
  let (xMin, yMin, xMax, yMax) = canvaLimits(path)
  var point:Point
  point.x = -xMin
  point.y = -yMin
  var surf = newImage(xMax-xMin, yMax-yMin)
  surf.fill(color(0, 0, 0))
  echo "dessin de la fractale sur l'image..."
  echo '-'.repeat(50)
  let fiftieth = max(len(path) div 50, 1)

  for i, a in path:
    let p = i/len(path)
    if i mod fiftieth == 0:
      stdout.write("-")
      stdout.flushFile()
    surf.execAction(point, a, true, p)
  echo ""
  echo "sauvegarde..."
  surf.writeFile( name&".png")

