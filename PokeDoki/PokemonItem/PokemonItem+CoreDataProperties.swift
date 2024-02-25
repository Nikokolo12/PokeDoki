//
//  PokemonItem+CoreDataProperties.swift
//  PokeDoki
//
//  Created by Soto Nicole on 25.02.24.
//
//

import Foundation
import CoreData


extension PokemonItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonItem> {
        return NSFetchRequest<PokemonItem>(entityName: "PokemonItem")
    }

    @NSManaged public var height: Double
    @NSManaged public var types: NSObject?
    @NSManaged public var image: Data?
    @NSManaged public var weight: Double
    @NSManaged public var index: Int64

}

extension PokemonItem : Identifiable {

}
