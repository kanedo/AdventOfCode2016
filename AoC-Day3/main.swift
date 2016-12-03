//
//  main.swift
//  AoC-Day3
//
//  Created by Gabriel Bretschner on 03.12.16.
//  Copyright © 2016 Gabriel Bretschner. All rights reserved.
//

import Foundation

func triangleTest(a:Int, b:Int, c:Int) -> Bool {
  if(a + b <= c || b + c <= a || c + a <= b){
    return false
  }
  return true
}


assert(!triangleTest(a: 5, b: 10, c: 25))


var validTriangles = 0
var triangles = 0
var validColumnTriangles = 0
var columnTriangles = 0

do{
  let input = try String(contentsOfFile: "InputDay3.strings")
  
  /**
   * Puzzle 1
   **/
  for line in input.characters.split(separator: "\n"){
    let triangleSides: [Int] = String(line).characters.split(separator: " ").map({val in return Int(String(val)) ?? 0})
    if(triangleSides.count == 3){
      triangles += 1
      if(triangleTest(a: triangleSides[0], b: triangleSides[1], c: triangleSides[2])){
        validTriangles += 1
      }
    }else{
      assert(false)
    }
  }
  
  /**
   * Puzzle 2
   **/
  var valueCounter = 0
  var firstRow: [Int] = []
  var secondRow: [Int] = []
  var thirdRow: [Int] = []
  
  for value in input.components(separatedBy: [" ", "\n"]) as [String]{
    let stringVal = String(value)!
    let intValue = Int(stringVal) ?? -1
    if(stringVal == "" || intValue == -1){
      continue
    }
    
    switch(valueCounter % 3){
    case 0:
      firstRow.append(intValue)
      if(firstRow.count == 3){
        columnTriangles += 1
        validColumnTriangles += triangleTest(a: firstRow[0], b: firstRow[1], c: firstRow[2]) ? 1 : 0
        firstRow = []
      }

    case 1:
      secondRow.append(intValue)
      if(secondRow.count == 3){
        columnTriangles += 1
        validColumnTriangles += triangleTest(a: secondRow[0], b: secondRow[1], c: secondRow[2]) ? 1 : 0
        secondRow = []
      }
    case 2:
      thirdRow.append(intValue)
      if(thirdRow.count == 3){
        columnTriangles += 1
        validColumnTriangles += triangleTest(a: thirdRow[0], b: thirdRow[1], c: thirdRow[2]) ? 1 : 0
        thirdRow = []
      }

    default: assert(false)
    }
    
    valueCounter += 1
  }
}catch let e {
  print("Some error \(e)")
}

print("valid row    triangles: \(validTriangles)/\(triangles)")
print("valid column triangles: \(validColumnTriangles)/\(columnTriangles)")
