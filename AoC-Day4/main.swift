//
//  main.swift
//  AoC-Day4
//
//  Created by Gabriel Bretschner on 04.12.16.
//  Copyright © 2016 Gabriel Bretschner. All rights reserved.
//

import Foundation


struct Sector {
  let hash : String
  let id: Int
  let valid: Bool
  init(_ hash: String) {
    self.hash = hash
    let parsedHash = Sector.parseHash(hash: hash)
    self.id = parsedHash.0
    self.valid = parsedHash.1
  }
  
  static func parseHash(hash: String) -> (Int, Bool) {
    var histogram : [String: Int] = [:]
    var isId = false
    var stringChecksum = ""
    var stringID = ""
    for c in hash.characters {
      let s = String(c)
      switch(s){
        case "-":break
        case "[":
          isId = true
        break
      case "]":
        break
      case _ where Int(s) != nil:
        stringID += s
        break
      default:
        if(!isId){
          if(histogram[s] == nil){
            histogram[s] = 0
          }
          histogram[s] = (histogram[s]! as Int) + 1
        }else{
          stringChecksum += s
        }
        break
      }
    }

    let checksum: [String] = stringChecksum.characters.map({ a in return String(a)})
    if(checksum.count == 5){
      var i = 0
      let histSorted = histogram.sorted(by: {a, b in
        if (a.value > b.value){
          return true
        }
        if(a.value == b.value && a < b){
          return true
        }
        return false
      })
      for (key, _) in histSorted {
        if(i > 4){
          break
        }
        if(key != checksum[i]){
          return (0, false)
        }
        i += 1
      }
      return (Int(stringID)!, true)
    }
    return (0, false)
  }
  
  func decrypt() -> String {
    var decryptedString = ""
    parse: for c in self.hash.characters {
      let s = String(c)
      switch c {
      case "-":
        decryptedString += " "
        break
      case _ where Int(s) != nil:
        break parse
      default:
        guard let i = UnicodeScalar(s)?.value else {
          break
        }
        let shifted = (Int(i) - 97 + self.id) % 26 + 97
        guard let d = UnicodeScalar(shifted) else {
          break
        }
        decryptedString += String(d)
      }
    }
    return decryptedString
  }
}

let tests: Dictionary<String, (Int, Bool)> = [
  "aaaaa-bbb-z-y-x-123[abxyz]" : (123, true),
  "a-b-c-d-e-f-g-h-987[abcde]" : (987, true),
  "not-a-real-room-404[oarel]" : (404, true),
  "totally-real-room-200[decoy]" : (0, false)
]

for test in tests{
  print("Test hash \(test.key) is \(test.value):")
  let res = Sector.parseHash(hash: test.key)
  print("\t\(res)")
}

let testDecrypt = Sector("qzmt-zixmtkozy-ivhz-343[zimth]")

do{
  let input = try String(contentsOfFile: "InputDay4.strings")
  var sum = 0
  for l in input.characters.split(separator: "\n"){
    let line = String(l)
    let sector = Sector(line)
    if(sector.valid){
      let decryptedMessage = sector.decrypt()
      if(decryptedMessage.contains("northpole")){
        print(sector.id, decryptedMessage)
      }
      sum += sector.id
    }
  }
  print(sum)
}catch let e {
  print("Some error \(e)")
}
