
import Foundation
import CoreData


extension HistoryInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryInfo> {
        return NSFetchRequest<HistoryInfo>(entityName: "HistoryInfo")
    }

    @NSManaged public var item: String?
    @NSManaged public var price: String?

}
