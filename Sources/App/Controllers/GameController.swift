//
//  GameController.swift
//  App
//
//  Created by Alexander Trust on 30.07.19.
//

import Foundation
import Vapor
import FluentPostgreSQL

class GameController: RouteCollection {
    
    // create routes for the corresponding functions
    func boot(router: Router) throws {
        
        // routes for the API
        let gamesRoutes = router.grouped("api/games")
        gamesRoutes.get("/", use: getAll)
        gamesRoutes.get(Game.parameter, use: getByID)
        gamesRoutes.get("genres", String.parameter, use: getByGenre)
        gamesRoutes.post(Game.self, at: "/", use: createGame)
        gamesRoutes.put(Game.self, at: "/", use: editGame)
        gamesRoutes.delete(Game.parameter, use: deleteGame)
        
        let frontendGamesRoutes = router.grouped("games")
        frontendGamesRoutes.get("/", use: frontendGetAll)
    }
    
    // retrieve all games
    func getAll(req: Request) -> Future<[Game]> {
        Game.query(on: req).all()
    }
    
    /* struct DisplayGames: Codable {
        let games: Game.query(on: req).all()
    } */
    
    func frontendGetAll(req: Request) throws -> Future<View> {
        return Game.query(on: req).all().flatMap(to: View.self) { games in
            let gamesData = games.isEmpty ? nil : games
            let context = GamesContext(title: "Alle Spiele", games: gamesData)
            return try req.view().render("games", context)
        }
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

struct GamesContext: Encodable {
    let title: String
    let games: [Game]?
}
