/**
 * Advent of Code 2016 - Day 1
 */
import Cocoa

struct Instruction{
  let direction: String
  let value: Int
  
  init(valueString: String) {
    let valueArray = Array(valueString.characters)
    var directionIndex = 0
    while(valueArray[directionIndex] == " "){
      directionIndex += 1
    }
    direction = String(valueArray[directionIndex])
    
    let index = valueString.index(valueString.startIndex, offsetBy: directionIndex + 1 )
    value = Int(valueString.substring(from: index)) ?? 0
  }
}

enum CompassPoint {
  case north
  case south
  case east
  case west
}

func advance(instruction: Instruction, previousDirection: CompassPoint, currentCoordinate: (Int, Int)) -> ((Int, Int), CompassPoint) {
  var newCoordinate = (currentCoordinate, previousDirection)
  switch(previousDirection){
  case .north:
    if(instruction.direction == "L"){
      newCoordinate.1 = .west
      newCoordinate.0.0 -= instruction.value
    }else{
      newCoordinate.1 = .east
      newCoordinate.0.0 += instruction.value
    }
    break
  case .east:
    if(instruction.direction == "L"){
      newCoordinate.1 = .north
      newCoordinate.0.1 += instruction.value
    }else{
      newCoordinate.1 = .south
      newCoordinate.0.1 -= instruction.value
    }
    break
  case .south:
    if(instruction.direction == "L"){
      newCoordinate.1 = .east
      newCoordinate.0.0 += instruction.value
    }else{
      newCoordinate.1 = .west
      newCoordinate.0.0 -= instruction.value
    }
    break
  case .west:
    if(instruction.direction == "L"){
      newCoordinate.1 = .south
      newCoordinate.0.1 -= instruction.value
    }else{
      newCoordinate.1 = .north
      newCoordinate.0.1 += instruction.value
    }
    break
  }
  return newCoordinate
}

func calcDistance(input: String) -> Int {
  let instructions = input.characters.split(separator: ",").map({ (a) -> Instruction in
    let s = String(a)
    return Instruction(valueString: s)
  })
  
  var coord = (0,0)
  var previousDirection : CompassPoint = .north
  for instruction in instructions {
    let res = advance(instruction: instruction, previousDirection: previousDirection, currentCoordinate: coord)
    coord = res.0
    previousDirection = res.1
  }
  return abs(coord.0) + abs(coord.1)
}

func calcDistanceFirstVisitTwice(input: String) -> Int {
  let instructions = input.characters.split(separator: ",").map({ (a) -> Instruction in
    let s = String(a)
    return Instruction(valueString: s)
  })
  
  var coord = (0,0)
  var coords: Set<String> = ["(\(coord.0),\(coord.1))"]
  var previousDirection : CompassPoint = .north
  instructionLoop: for instruction in instructions {
    let res = advance(instruction: instruction, previousDirection: previousDirection, currentCoordinate: coord)
    if(coord.0 == res.0.0){
      let upper = ((coord.1 < res.0.1) ? res.0.1 : coord.1 - 1)
      let lower = ((coord.1 > res.0.1) ? res.0.1 : coord.1 + 1)
      for i in lower...upper {
        let hash = "(\(coord.0),\(i))"
        if(coords.contains(hash)){
          coord = (coord.0, i)
          break instructionLoop;
        }else{
          coords.insert(hash)
        }
      }
      
    }
    if(coord.1 == res.0.1){
      let upper = ((coord.0 < res.0.0) ? res.0.0 : coord.0 - 1)
      let lower = ((coord.0 > res.0.0) ? res.0.0 : coord.0 + 1)
      for i in lower...upper {
        let hash = ("(\(i),\(coord.1))")
        if(coords.contains(hash)){
          coord = (i, coord.1)
          break instructionLoop;
        }else{
          coords.insert(hash)
        }
      }
    }
    coord = res.0
    previousDirection = res.1
  }
  return abs(coord.0) + abs(coord.1)
}

var test1 = "R2, L3"
print(test1 + " distance 5…")
assert(calcDistance(input:test1) == 5)
print("passed")

var test2 = "R2, R2, R2"
print(test2 + " distance 2…")
assert(calcDistance(input:test2) == 2)
print("passed")

var test3 = "R5, L5, R5, R3"
print(test3 + " distance 12…")
assert(calcDistance(input:test3) == 12)
print("passed")

var test4 = "R8, R4, R4, R8"
print(test4 + " distance of first coordinate visited twice 4…")
assert(calcDistanceFirstVisitTwice(input: test4) == 4)
print("passed")

var inputDayOne = "R3, L5, R2, L1, L2, R5, L2, R2, L2, L2, L1, R2, L2, R4, R4, R1, L2, L3, R3, L1, R2, L2, L4, R4, R5, L3, R3, L3, L3, R4, R5, L3, R3, L5, L1, L2, R2, L1, R3, R1, L1, R187, L1, R2, R47, L5, L1, L2, R4, R3, L3, R3, R4, R1, R3, L1, L4, L1, R2, L1, R4, R5, L1, R77, L5, L4, R3, L2, R4, R5, R5, L2, L2, R2, R5, L2, R194, R5, L2, R4, L5, L4, L2, R5, L3, L2, L5, R5, R2, L3, R3, R1, L4, R2, L1, R5, L1, R5, L1, L1, R3, L1, R5, R2, R5, R5, L4, L5, L5, L5, R3, L2, L5, L4, R3, R1, R1, R4, L2, L4, R5, R5, R4, L2, L2, R5, R5, L5, L2, R4, R4, L4, R1, L3, R1, L1, L1, L1, L4, R5, R4, L4, L4, R5, R3, L2, L2, R3, R1, R4, L3, R1, L4, R3, L3, L2, R2, R2, R2, L1, L4, R3, R2, R2, L3, R2, L3, L2, R4, L2, R3, L4, R5, R4, R1, R5, R3"
print("distance to goal: \(calcDistance(input:inputDayOne))")
print("distance to first revisited: \(calcDistanceFirstVisitTwice(input:inputDayOne))")
