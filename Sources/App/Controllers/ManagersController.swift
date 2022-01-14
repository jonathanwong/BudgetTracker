//
//  File.swift
//  
//
//  Created by Jonathan Wong on 12/26/21.
//

import Vapor

struct ManagersController: RouteCollection {
  
  func boot(routes: RoutesBuilder) throws {
    let managerRoutes = routes.grouped("v1", "managers")
    managerRoutes.get(use: managers)
    managerRoutes.post(use: createManager)
    managerRoutes.get(":managerID", "employees", use: employees)
  }
  
  /// GET v1/managers
  func managers(_ req: Request) -> EventLoopFuture<[Manager]> {
    Manager.query(on: req.db).all()
  }
  
  /// POST v1/managers
  func createManager(_ req: Request) throws -> EventLoopFuture<Manager> {
    let manager = try req.content.decode(Manager.self)
    return manager.save(on: req.db).map { manager }
  }
  
  /// GET v1/:managerID/employees
  func employees(_ req: Request) throws -> EventLoopFuture<[Employee]> {
    Manager.find(req.parameters.get("managerID"), on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap { manager in
        manager.$employees.query(on: req.db).all()
    }
    
  }
}
