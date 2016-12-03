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
do{
  let input = try String(contentsOfFile: "InputDay3.strings")
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
}catch let e {
  print("Some error \(e)")
}

print("valid triangles: \(validTriangles)/\(triangles)")
