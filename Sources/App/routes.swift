import Vapor
import Foundation
import FluentSQLite

struct WelcomeContext: Encodable {
    var message: String
}


/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let gameController = GameController()
    try router.register(collection: gameController)
    
    router.get("hello") { request in
        return try request.view().render("index")
    }
    
    router.get("welcome") { request -> Future<View> in
        let context = WelcomeContext(message: "Welcome to Leaf Templates")
        return try request.view().render("index", context)
    }
}
