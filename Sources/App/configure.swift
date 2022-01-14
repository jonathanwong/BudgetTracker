import Fluent
import FluentSQLiteDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
  // uncomment to serve files from /Public folder
  // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
  
  app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
  
  app.migrations.add(CreateEmployee())
  app.migrations.add(CreateManager())
  app.migrations.add(CreateTraining())
  app.migrations.add(AddTrainings())
  app.migrations.add(AddManagersAndEmployees())
  app.migrations.add(CreateEmployeePivot())
  app.logger.logLevel = .debug
  
  try app.autoMigrate().wait()
  
  // register routes
  try routes(app)
}
