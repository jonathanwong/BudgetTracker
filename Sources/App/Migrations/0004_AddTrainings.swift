//
//  File.swift
//  
//
//  Created by Jonathan Wong on 12/27/21.
//

import Foundation
import Fluent

struct AddTrainings: Migration {
  
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    let training1 = Training(id: UUID(), name: "WWDC", price: 1699)
    let training2 = Training(id: UUID(), name: "360 iDev", price: 1099)
    let training3 = Training(id: UUID(), name: "Cocoaconf", price: 1299)
    let training4 = Training(id: UUID(), name: "AWS", price: 1500)
    let training5 = Training(id: UUID(), name: "Swift by San Diego", price: 800)
    let training6 = Training(id: UUID(), name: "Swift Bootcamp", price: 600)
    let training7 = Training(id: UUID(), name: "iOS for Beginners", price: 400)
    let training8 = Training(id: UUID(), name: "Advanced Swift", price: 1499)
    let training9 = Training(id: UUID(), name: "Raise Your Swift", price: 999)
    let training10 = Training(id: UUID(), name: "Swifty API Design", price: 999)
    
    _ = training1.save(on: database)
    _ = training2.save(on: database)
    _ = training3.save(on: database)
    _ = training4.save(on: database)
    _ = training5.save(on: database)
    _ = training6.save(on: database)
    _ = training7.save(on: database)
    _ = training8.save(on: database)
    _ = training9.save(on: database)
    return training10.save(on: database)
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    Training.query(on: database)
      .delete()
  }
}
