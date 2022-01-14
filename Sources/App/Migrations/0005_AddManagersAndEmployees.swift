//
//  File.swift
//  
//
//  Created by Jonathan Wong on 12/27/21.
//

import Foundation
import Fluent

struct AddManagersAndEmployees: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    let m1 = Manager(
      id: UUID(),
      firstName: "Jonathan",
      lastName: "Wong",
      budget: 4000
    )
    _ = m1.save(on: database).map { m1 }
//    return Employee(
//      id: UUID(),
//      firstName: "John",
//      lastName: "Appleseed",
//      managerID: m1.id!).save(on: database)
    _ = Employee(
      id: UUID(),
      firstName: "John",
      lastName: "Appleseed",
      managerID: m1.id!).save(on: database)
    _ = Employee(
      id: UUID(),
      firstName: "Owen",
      lastName: "Fisher",
      managerID: m1.id!).save(on: database)
    _ = Employee(
      id: UUID(),
      firstName: "Jane",
      lastName: "Smith",
      managerID: m1.id!).save(on: database)
    _ = Employee(
      id: UUID(),
      firstName: "Zach",
      lastName: "Powell",
      managerID: m1.id!).save(on: database)
    
    let m2 = Manager(
      id: UUID(),
      firstName: "William",
      lastName: "Ying",
      budget: 8000
    )
    _ = m2.save(on: database).map { m2 }
    _ = Employee(
      id: UUID(),
      firstName: "Samantha",
      lastName: "James",
      managerID: m2.id!).save(on: database)
    _ = Employee(
      id: UUID(),
      firstName: "Chris",
      lastName: "Wu",
      managerID: m2.id!).save(on: database)
    _ = Employee(
      id: UUID(),
      firstName: "Jessica",
      lastName: "Smith",
      managerID: m2.id!).save(on: database)
    
    let m3 = Manager(
      id: UUID(),
      firstName: "Phoebe",
      lastName: "Katz",
      budget: 6000
    )
    _ = m3.save(on: database).map { m3 }
    _ = Employee(
      id: UUID(),
      firstName: "Bradley",
      lastName: "Nerm",
      managerID: m3.id!).save(on: database)
    _ = Employee(
      id: UUID(),
      firstName: "Katie",
      lastName: "Beck",
      managerID: m3.id!).save(on: database)
    _ = Employee(
      id: UUID(),
      firstName: "Karen",
      lastName: "Sowen",
      managerID: m3.id!).save(on: database)
    _ = Employee(
      id: UUID(),
      firstName: "Kevin",
      lastName: "Sun",
      managerID: m3.id!).save(on: database)
    _ = Employee(
      id: UUID(),
      firstName: "Alice",
      lastName: "Cleary",
      managerID: m3.id!).save(on: database)
    
    let m4 = Manager(
      id: UUID(),
      firstName: "Karen",
      lastName: "Thompson",
      budget: 10000
    )
    _ = m4.save(on: database).map { m4 }
    _ = Employee(
      id: UUID(),
      firstName: "Ned",
      lastName: "Martin",
      managerID: m4.id!).save(on: database)
    return Employee(
      id: UUID(),
      firstName: "Liz",
      lastName: "Ivy",
      managerID: m4.id!).save(on: database)
    
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    _ = Manager.query(on: database).delete()
    return Employee.query(on: database).delete()
  }
  
  
}
