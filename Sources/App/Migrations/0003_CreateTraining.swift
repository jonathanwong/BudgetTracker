//
//  File.swift
//  
//
//  Created by Jonathan Wong on 12/26/21.
//

import Fluent

struct CreateTraining: Migration {
  
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("trainings")
      .id()
      .field("name", .string, .required)
      .field("price", .int16, .required)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("trainings").delete()
  }
}
