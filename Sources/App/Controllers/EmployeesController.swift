//
//  File.swift
//  
//
//  Created by Jonathan Wong on 12/26/21.
//

import Vapor

struct EmployeesController: RouteCollection {
  
  func boot(routes: RoutesBuilder) throws {
    let employeeRoutes = routes.grouped("v1", "employees")
    employeeRoutes.get(use: employees)
    employeeRoutes.post(use: createEmployee)
    employeeRoutes.put(":employeeID", use: updateEmployee)
    employeeRoutes.delete(":employeeID", use: deleteEmployee)
    employeeRoutes.get(":employeeID", "manager", use: managerForEmployee)
    employeeRoutes.get(":employeeID", "trainings", use: employeeTrainings)
  }
  
  /// GET v1/employees
  func employees(_ req: Request) -> EventLoopFuture<[Employee]> {
     Employee.query(on: req.db).all()
  }
  
  /// POST v1/employees
  func createEmployee(_ req: Request) throws -> EventLoopFuture<Employee> {
    let employeeWithManager = try req.content.decode(EmployeeWithManager.self)
    let employee = Employee(
      firstName: employeeWithManager.firstName,
      lastName: employeeWithManager.lastName,
      managerID: employeeWithManager.managerID)
    return employee.save(on: req.db).map {
      employee
    }
  }
  
  /// PUT v1/employees/:employeeID
  func updateEmployee(_ req: Request) throws -> EventLoopFuture<Employee> {
    let updatedEmployeeWithManager = try req.content.decode(EmployeeWithManager.self)
    return Employee.find(
      req.parameters.get("employeeID"),
      on: req.db)
      .unwrap(or: Abort(.notFound)).flatMap { employee in
        employee.firstName = updatedEmployeeWithManager.firstName
        employee.lastName = updatedEmployeeWithManager.lastName
        employee.$manager.id = updatedEmployeeWithManager.managerID
        return employee.save(on: req.db).map {
          employee
        }
      }
  }
  
  /// DELETE v1/employees/:employeeID
  func deleteEmployee(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
    Employee.find(req.parameters.get("employeeID"), on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap { acronym in
        acronym.delete(on: req.db)
          .transform(to: .noContent)
      }
  }
 
  /// GET v1/employees/:employeeID/manager
  func managerForEmployee(_ req: Request) -> EventLoopFuture<Manager> {
    Employee.find(req.parameters.get("employeeID"), on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap { employee in
        employee.$manager.get(on: req.db)
      }
  }
  
  /// GET v1/employees/:employeeID/trainings
  func employeeTrainings(_ req: Request) -> EventLoopFuture<[Training]> {
    Employee.find(req.parameters.get("employeeID"), on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap { employee in
        employee.$trainings.query(on: req.db).all()
      }
  }
}

struct EmployeeWithManager: Content {
  let firstName: String
  let lastName: String
  let managerID: UUID
}
