

import Foundation
import CoreData


extension PeopleInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PeopleInfo> {
        return NSFetchRequest<PeopleInfo>(entityName: "PeopleInfo")
    }

    @NSManaged public var price: String?
    @NSManaged public var item: String?

}
