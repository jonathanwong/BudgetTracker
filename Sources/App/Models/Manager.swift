//
//  File.swift
//  
//
//  Created by Jonathan Wong on 12/26/21.
//

import Vapor
import Fluent

final class Manager: Model {
  
  static var schema = "managers"
  
  @ID
  var id: UUID?
  
  @Field(key: "first_name")
  var firstName: String
  
  @Field(key: "last_name")
  var lastName: String
  
  @Field(key: "budget")
  var budget: Int
 
  @Children(for: \.$manager)
  var employees: [Employee]
  
  init() {}
  
  init(
    id: UUID? = nil,
    firstName: String,
    lastName: String,
    budget: Int
  ) {
    self.id = id
    self.firstName = firstName
    self.lastName = lastName
    self.budget = budget
  }
}

extension Manager: Content {}
