import Vapor

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
    
    // retrieve a list of all games
    router.get("api/games") { req -> Future<[Game]> in
        return Game.query(on: req).all()
    }
}
