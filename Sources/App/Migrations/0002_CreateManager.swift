//
//  File.swift
//  
//
//  Created by Jonathan Wong on 12/26/21.
//

import Fluent

struct CreateManager: Migration {
  
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("managers")
      .id()
      .field("first_name", .string, .required)
      .field("last_name", .string, .required)
      .field("budget", .int16, .required)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("managers").delete()
  }
}
