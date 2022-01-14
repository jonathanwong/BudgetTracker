//
//  File.swift
//  
//
//  Created by Jonathan Wong on 12/26/21.
//

import Vapor
import Fluent

final class Training: Model {
  
  static var schema = "trainings"
  
  @ID
  var id: UUID?
  
  @Field(key: "name")
  var name: String
  
  @Field(key: "price")
  var price: Int
  
  @Siblings(through: TrainingEmployeePivot.self, from: \.$training, to: \.$employee)
  var employees: [Employee]
  
  init() {}
  
  init(
    id: UUID? = nil,
    name: String,
    price: Int
  ) {
    self.id = id
    self.name = name
    self.price = price
  }
}

extension Training: Content {}
