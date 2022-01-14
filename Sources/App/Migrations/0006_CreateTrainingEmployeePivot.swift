//
//  File.swift
//  
//
//  Created by Jonathan Wong on 1/10/22.
//

import Fluent

struct CreateEmployeePivot: Migration {
  
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("training-employee-pivot")
      .id()
      .field("trainingID", .uuid, .required,
             .references("trainings", "id", onDelete: .cascade))
      .field("employeeID", .uuid, .required,
             .references("employees", "id", onDelete: .cascade))
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("training-employee-pivot").delete()
  }
}
