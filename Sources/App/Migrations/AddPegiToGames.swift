//
//  AddPegiToGames.swift
//  App
//
//  Created by Alexander Trust on 30.07.19.
//

import Foundation
import FluentPostgreSQL
import Vapor

class AddPegiToGames: Migration {
    typealias Database = PostgreSQLDatabase
    
    static func prepare(on conn: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return Database.update(Game.self, on: conn) { builder in
            builder.field(for: \.pegi)
        }
    }
    
    static func revert(on conn: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return Database.update(Game.self, on: conn) { builder in
            builder.deleteField(for: \.pegi)
        }
    }
}
