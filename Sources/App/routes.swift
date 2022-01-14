import Fluent
import Vapor

func routes(_ app: Application) throws {  
  try app.register(collection: EmployeesController())
  try app.register(collection: ManagersController())
  try app.register(collection: TrainingsController())
  
}
