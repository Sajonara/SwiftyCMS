import Vapor
import Foundation
import FluentSQLite

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let gameController = GameController()
    try router.register(collection: gameController)
}
