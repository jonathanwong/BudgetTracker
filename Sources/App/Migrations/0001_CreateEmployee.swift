//
//  File.swift
//  
//
//  Created by Jonathan Wong on 12/26/21.
//

import Fluent

struct CreateEmployee: Migration {
  
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("employees")
      .id()
      .field("first_name", .string, .required)
      .field("last_name", .string, .required)
      .field("managerID", .uuid, .required)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("employees").delete()
  }
}
