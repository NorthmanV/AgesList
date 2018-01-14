//
//  Person+CoreDataProperties.swift
//  AgesList
//
//  Created by Руслан Акберов on 14.01.2018.
//  Copyright © 2018 Ruslan Akberov. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
