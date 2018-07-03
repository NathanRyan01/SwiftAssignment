

import Foundation
import CoreData


extension CartReview {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartReview> {
        return NSFetchRequest<CartReview>(entityName: "CartReview")
    }

    @NSManaged public var comment: String?
    @NSManaged public var user: String?

}
