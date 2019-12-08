//
//  ArticleData+CoreDataProperties.swift
//  
//
//  Created by Rupesh Jaiswal on 08/12/19.
//
//

import Foundation
import CoreData


extension ArticleData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleData> {
        return NSFetchRequest<ArticleData>(entityName: "ArticleData")
    }

    @NSManaged public var title: String?
    @NSManaged public var publishedDate: String?
    @NSManaged public var source: String?
    @NSManaged public var abstract: String?
    @NSManaged public var byline: String?
    @NSManaged public var type: String?

}
