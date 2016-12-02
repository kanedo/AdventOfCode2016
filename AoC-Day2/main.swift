//
//  main.swift
//  AoC-Day2
//
//  Created by Gabriel Bretschner on 02.12.16.
//  Copyright © 2016 Gabriel Bretschner. All rights reserved.
//
import Cocoa

func decodeInstructions(input: [String]) -> [Int] {
  let numPad = [[1,2,3], [4,5,6], [7,8,9]]
  
  let instructions = input.map({line in Array(line.characters)})
  var code: [Int] = []
  var x = 1
  var y = 1
  
  for instruction in instructions{
    for move in instruction {
      switch(move){
      case "U":
        if x > 0 {
          x -= 1
        }
        break
      case "L":
        if y > 0 {
          y -= 1
        }
        break
      case "D":
        if x < 2 {
          x += 1
        }
        break
      case "R":
        if y < 2 {
          y += 1
        }
        break
      default:
        break
      }
    }
    code.append(numPad[x][y])
  }
  return code
}

func decodeInstructionsAlphaNumPad(input: [String]) -> [String] {
  let numPad = [
    ["x", "x", "1", "x", "x"],
    ["x", "2", "3", "4", "x"],
    ["5", "6", "7", "8", "9"],
    ["x", "A", "B", "C", "x"],
    ["x", "x", "D", "x", "x"]]
  
  let instructions = input.map({line in Array(line.characters)})
  var code: [String] = []
  var x = 2
  var y = 0
  
  for instruction in instructions{
    for move in instruction {
      switch(move){
      case "U":
        if x > 0 && numPad[x-1][y] != "x" {
          x -= 1
        }
        break
      case "L":
        if y > 0 && numPad[x][y-1] != "x"{
          y -= 1
        }
        break
      case "D":
        if x < 4 && numPad[x+1][y] != "x"{
          x += 1
        }
        break
      case "R":
        if y < 4 && numPad[x][y+1] != "x"{
          y += 1
        }
        break
      default:
        break
      }
    }
    code.append(numPad[x][y])
  }
  return code
}


let inputDay2 = [
  "URULLLLLRLDDUURRRULLLDURRDRDRDLURURURLDLLLLRUDDRRLUDDDDDDLRLRDDDUUDUDLDULUDLDURDULLRDDURLLLRRRLLRURLLUDRDLLRRLDDRUDULRRDDLUUUDRLDLURRRULURRDLLLDDDLUDURDDRLDDDLLRULDRUDDDLUDLURUDLLRURRUURUDLLLUUUUDDURDRDDDLDRRUDURDLLLULUDURURDUUULRULUDRUUUUDLRLUUUUUDDRRDDDURULLLRRLDURLDLDRDLLLUULLRRLLLLDRLRDRRDRRUDDLULUUDDDDRRUUDDLURLRDUUDRRLDUDLRRRLRRUUDURDRULULRDURDRRRDLDUUULRDDLRLRDLUUDDUDDRLRRULLLULULLDDDRRDUUUDDRURDDURDRLRDLDRDRULRLUURUDRLULRLURLRRULDRLRDUDLDURLLRLUDLUDDURDUURLUDRLUL",
  "LLLUUURUULDDDULRRDLRLLLLLLLLRURRDLURLUDRRDDULDRRRRRRLDURRULDDULLDDDRUUDLUDULLDLRRLUULULRULURDURLLDULURDUDLRRLRLLDULLRLDURRUULDLDULLRDULULLLULDRLDLDLDLDDLULRLDUDRULUDDRDDRLRLURURRDULLUULLDRRDRRDLDLLRDLDDUUURLUULDDRRRUULDULDDRDDLULUDRURUULLUDRURDRULDRUULLRRDURUDDLDUULLDDRLRRDUDRLRRRLDRLRULDRDRRUDRLLLDDUDLULLURRURRLUURDRLLDLLDUDLUUURRLRDDUDRLUDLLRULLDUUURDLUUUDUDULRLDLDRUUDULRDRRUDLULRLRDLDRRDDDUDLDLDLRUURLDLLUURDLDLRDLDRUDDUURLLLRDRDRRULLRLRDULUDDDLUDURLDUDLLRULRDURDRDLLULRRDLLLDUURRDUDDLDDRULRRRRLRDDRURLLRRLLL",
  "DRURLDDDDRLUDRDURUDDULLRRLLRLDDRLULURLDURRLDRRLRLUURDDRRDLRDLDLULDURUDRLRUDULRURURLRUDRLLDDUDDRDLDRLLDDLRRDRUUULDUUDRUULRLLDLLULLLRRDRURDLDDRRDDUDDULLDUUULDRUDLDLURLDRURUDLRDDDURRLRDDUDLLLRRUDRULRULRRLLUUULDRLRRRLLLDLLDUDDUUDRURLDLRRUUURLUDDDRRDDLDDDDLUURDDULDRLRURLULLURRDRLLURLLLURDURLDLUDUUDUULLRLDLLLLULRDDLDUDUDDDUULURRLULDLDRLRDRLULLUDDUUUUURDRURLDUULDRRDULUDUDLDDRDLUDDURUDURLDULRUDRRDLRLRDRRURLDLURLULULDDUUDLRLLLLURRURULDDRUUULLDULDRDULDDDLLLRLULDDUDLRUDUDUDURLURLDDLRULDLURD",
  "DRUDRDURUURDLRLUUUUURUDLRDUURLLDUULDUULDLURDDUULDRDDRDULUDDDRRRRLDDUURLRDLLRLRURDRRRDURDULRLDRDURUDLLDDULRDUDULRRLLUDLLUUURDULRDDLURULRURDDLRLLULUDURDRRUDLULLRLDUDLURUDRUULDUDLRDUDRRDULDDLDRLRRULURULUURDULRRLDLDULULRUUUUULUURLURLRDLLRRRRLURRUDLRLDDDLDRDRURLULRDUDLRLURRDRRLRLLDLDDLLRRULRLRLRUDRUUULLDUULLDDRLUDDRURLRLDLULDURLLRRLDLLRDDDUDDUULLUDRUDURLLRDRUDLUDLLUDRUUDLRUURRRLLUULLUUURLLLRURUULLDLLDURUUUULDDDLRLURDRLRRRRRRUDLLLRUUULDRRDLRDLLDRDLDDLDLRDUDLDDRDDDDRULRRLRDULLDULULULRULLRRLLUURUUUDLDLUDUDDDLUUDDDDUDDDUURUUDRDURRLUULRRDUUDDUDRRRDLRDRLDLRRURUUDRRRUUDLDRLRDURD",
  "DDDLRURUDRRRURUUDLRLRDULDRDUULRURRRUULUDULDDLRRLLRLDDLURLRUDRLRRLRDLRLLDDLULDLRRURDDRDLLDDRUDRRRURRDUDULUDDULRRDRLDUULDLLLDRLUDRDURDRRDLLLLRRLRLLULRURUUDDRULDLLRULDRDLUDLULDDDLLUULRRLDDUURDLULUULULRDDDLDUDDLLLRRLLLDULRDDLRRUDDRDDLLLLDLDLULRRRDUDURRLUUDLLLLDUUULDULRDRULLRDRUDULRUUDULULDRDLDUDRRLRRDRLDUDLULLUDDLURLUUUDRDUDRULULDRDLRDRRLDDRRLUURDRULDLRRLLRRLDLRRLDLDRULDDRLURDULRRUDURRUURDUUURULUUUDLRRLDRDLULDURUDUDLUDDDULULRULDRRRLRURLRLRLUDDLUUDRRRLUUUDURLDRLRRDRRDURLLL"]
let testInput = ["ULL", "RRDDD", "LURDL", "UUUUD"]
assert(decodeInstructions(input: testInput) == [1,9,8,5])
print(decodeInstructions(input: inputDay2))

assert(decodeInstructionsAlphaNumPad(input: testInput) == ["5", "D", "B", "3"])
print(decodeInstructionsAlphaNumPad(input: inputDay2))
