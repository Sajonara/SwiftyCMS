//
//  Game.swift
//  App
//
//  Created by Alexander Trust on 28.07.19.
//

import Foundation
import Vapor
import FluentSQLite

final class Game: Content {
    var id: Int?
    var title: String
    var pubyear: Int
    var genre: String
    
    init(title: String, pubyear: Int, genre: String) {
        self.title = title
        self.pubyear = pubyear
        self.genre = genre
    }
}

extension Game: Parameter {}

extension Game: SQLiteModel {
    static let entity: String = "games"
}

extension Game: Migration {}
