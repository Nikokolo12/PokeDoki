//
//  ListPokemon+CoreDataProperties.swift
//  PokeDoki
//
//  Created by Soto Nicole on 25.02.24.
//
//

import Foundation
import CoreData


extension ListPokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListPokemon> {
        return NSFetchRequest<ListPokemon>(entityName: "ListPokemon")
    }

    @NSManaged public var name: String?
    @NSManaged public var index: Int64

}

extension ListPokemon : Identifiable {

}
