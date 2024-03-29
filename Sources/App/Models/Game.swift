//
//  Game.swift
//  App
//
//  Created by Alexander Trust on 28.07.19.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class Game: Content {
    var id: Int?
    var title: String
    var pubyear: Int
    var genre: String
    var usk: Int
    var pegi: Int
    
    init(title: String, pubyear: Int, genre: String, usk: Int, pegi: Int) {
        self.title = title
        self.pubyear = pubyear
        self.genre = genre
        self.usk = usk
        self.pegi = pegi
    }
}

extension Game: Parameter {}

extension Game: PostgreSQLModel {
    static let entity: String = "games"
}

extension Game: Migration {}
