//
//  File.swift
//  
//
//  Created by Jonathan Wong on 12/26/21.
//

import Vapor
import Fluent

final class Employee: Model {
  
  static var schema = "employees"
 
  @Parent(key: "managerID")
  var manager: Manager
  
  @ID
  var id: UUID?
  
  @Field(key: "first_name")
  var firstName: String
  
  @Field(key: "last_name")
  var lastName: String
  
  @Siblings(through: TrainingEmployeePivot.self, from: \.$employee, to: \.$training)
  var trainings: [Training]
  
  init() {}
  
  init(
    id: UUID? = nil,
    firstName: String,
    lastName: String,
    managerID: Manager.IDValue
  ) {
    self.id = id
    self.firstName = firstName
    self.lastName = lastName
    self.$manager.id = managerID
  }
}

extension Employee: Content {}
