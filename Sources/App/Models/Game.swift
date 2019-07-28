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
    
    init(title: String, pubyear: Int) {
        self.title = title
        self.pubyear = pubyear
    }
}

extension Game: SQLiteModel {
    static let entity: String = "games"
}

extension Game: Migration {}
extension Game: Parameter {}
