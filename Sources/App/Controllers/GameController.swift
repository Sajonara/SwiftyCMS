//
//  GameController.swift
//  App
//
//  Created by Alexander Trust on 30.07.19.
//

import Foundation
import Vapor
import FluentSQLite

class GameController: RouteCollection {
    
    // create routes for the corresponding functions
    func boot(router: Router) throws {
        
        let gamesRoutes = router.grouped("api/games")
        
        gamesRoutes.get("/", use: getAll)
        gamesRoutes.get(Game.parameter, use: getByID)
        gamesRoutes.get("genres", String.parameter, use: getByGenre)
        gamesRoutes.post(Game.self, at: "/", use: createGame)
        gamesRoutes.put(Game.self, at: "/", use: editGame)
        gamesRoutes.delete(Game.parameter, use: deleteGame)
    }
    
    // retrieve all games
    func getAll(req: Request) -> Future<[Game]> {
        Game.query(on: req).all()
    }
    
    // retrieve a single game
    func getByID(req: Request) throws -> Future<Game> {
        return try req.parameters.next(Game.self)
    }
    
    // retrieve games by genre
    func getByGenre(req: Request) throws -> Future<[Game]> {
        let genre = try req.parameters.next(String.self)
        return try Game.query(on: req).filter(\Game.genre == genre).all()
    }
    
    // post a game to the database
    func createGame(req: Request, game: Game) -> Future<Game> {
      return game.save(on: req)
    }
    
    // delete a single game
    func deleteGame(req: Request) throws -> Future<Game> {
        return try req.parameters.next(Game.self).delete(on: req)
    }
    
    // edit a single game
    func editGame(req: Request, game: Game) throws -> Future<Game> {
        return try game.update(on: req)
    }
    
}
