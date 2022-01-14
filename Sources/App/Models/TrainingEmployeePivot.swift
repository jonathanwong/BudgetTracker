//
//  File.swift
//  
//
//  Created by Jonathan Wong on 1/10/22.
//

import Vapor
import Fluent

final class TrainingEmployeePivot: Model {
  static let schema = "training-employee-pivot"
  
  @ID
  var id: UUID?
  
  @Parent(key: "trainingID")
  var training: Training
  
  @Parent(key: "employeeID")
  var employee: Employee
  
  init() {}
  
  init(
    id: UUID? = nil,
    training: Training,
    employee: Employee
  ) throws {
    self.id = id
    self.$training.id = try training.requireID()
    self.$employee.id = try employee.requireID()
  }
}
