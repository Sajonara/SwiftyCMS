import Vapor
import Foundation
import FluentSQLite

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    // Post a game to the database
    router.post(Game.self, at: "api/game") { req, game -> Future<Game> in
        return game.save(on: req)
    }
    
    // retrieve games by genre
    router.get("api/games",String.parameter) { req -> Future<[Game]> in
        
        let genre = try req.parameters.next(String.self)
        return try Game.query(on: req).filter(\Game.genre == genre).all()
    }
    
    // retrieve a list of all games
    router.get("api/games") { req -> Future<[Game]> in
        return Game.query(on: req).all()
    }
    
    // retrieve a single game
    router.get("api/game", Game.parameter) { req -> Future<Game> in
        return try req.parameters.next(Game.self)
    }
    
    // delete a single game
    router.delete("api/game", Game.parameter) { req -> Future<Game> in
        try req.parameters.next(Game.self).delete(on: req)
    }
}
