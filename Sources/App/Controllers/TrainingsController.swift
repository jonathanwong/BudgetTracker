//
//  File.swift
//  
//
//  Created by Jonathan Wong on 12/26/21.
//

import Foundation
import Vapor

struct TrainingsController: RouteCollection {
  
  func boot(routes: RoutesBuilder) throws {
    let trainingRoutes = routes.grouped("v1", "trainings")
    trainingRoutes.get(use: trainings)
    trainingRoutes.post(use: createTraining)
    trainingRoutes.put(":trainingID", use: updateTraining)
    trainingRoutes.post(":trainingID", "employees", ":employeeID", use: trainingToEmployee)
    trainingRoutes.put(":trainingID", "employees", ":employeeID", use: updateTrainingToEmployee)
    trainingRoutes.get(":employeeID", "employees", use: trainingsForEmployee)
    trainingRoutes.delete(":trainingID", "employees", ":employeeID",  use: removeTrainingsForEmployee)
  }
  
  /// POST v1/trainings
  func createTraining(_ req: Request) throws -> EventLoopFuture<Training> {
    let training = try req.content.decode(Training.self)
    return training.save(on: req.db).map {
      training 
    }
  }
  
  /// GET v1/trainings
  func trainings(_ req: Request) throws -> EventLoopFuture<[Training]> {
    Training.query(on: req.db).all()
  }
  
  /// PUT v1/trainings/:trainingID
  func updateTraining(_ req: Request) throws -> EventLoopFuture<Training> {
    let updatedTraining = try req.content.decode(Training.self)
    return Training.find(req.parameters.get("trainingID"), on: req.db)
      .unwrap(or: Abort(.notFound)).flatMap { training in
        training.name = updatedTraining.name
        training.price = updatedTraining.price
        return training.save(on: req.db).map { training }
      }
  }
  
  /// DELETE v1/trainings
  func deleteTraining(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
    Training.find(req.parameters.get("trainingID"), on: req.db)
      .unwrap(or: Abort(.notFound)).flatMap { training in
      training.delete(on: req.db)
        .transform(to: .noContent)
    }
  }
  
  /// POST v1/trainings/:trainingID/employees/:employeeID
  func trainingToEmployee(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
    let trainingQuery = Training.find(req.parameters.get("trainingID"), on: req.db)
      .unwrap(or: Abort(.notFound))
    let employeeQuery = Employee.find(req.parameters.get("employeeID"), on: req.db)
      .unwrap(or: Abort(.notFound))
    return trainingQuery.and(employeeQuery)
      .flatMap { training, employee in
        training.$employees
          .attach(employee, on: req.db)
          .transform(to: .created)
      }
  }
  
  /// PUT v1/trainings/:employeeID/employees
  func updateTrainingToEmployee(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
    let updatedTraining = try req.content.decode(Training.self)
    return Employee.find(req.parameters.get("employeeID"), on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap { employee in
        employee
          .$trainings
          .attach(updatedTraining, on: req.db)
          .transform(to: .created)
      }
  }
  
  /// GET v1/trainings/:employeeID/employees
  func trainingsForEmployee(_ req: Request) throws -> EventLoopFuture<[Training]> {
    Employee.find(req.parameters.get("employeeID"), on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap { employee in
        employee.$trainings.query(on: req.db).all()
    }
  }
  
  /// DELETE v1/trainings/:trainingID/employees/:employeeID
  func removeTrainingsForEmployee(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
    let trainingQuery = Training.find(req.parameters.get("trainingID"), on: req.db)
      .unwrap(or: Abort(.notFound))
    let employeeQuery = Employee.find(req.parameters.get("employeeID"), on: req.db)
      .unwrap(or: Abort(.notFound))
    return trainingQuery.and(employeeQuery)
      .flatMap { training, employee in
        training.$employees
          .detach(employee, on: req.db)
          .transform(to: .noContent)
      }
  }
}
