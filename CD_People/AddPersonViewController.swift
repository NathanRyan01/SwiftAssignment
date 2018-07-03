

import UIKit
import CoreData

class AddPersonViewController: UIViewController {

    //code data objects
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var personInfoManagedObject : PeopleInfo! = nil
    
    
    // outlets and action
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBAction func addUpdateAction(_ sender: Any) {
        
        // either save or update
        if personInfoManagedObject != nil {
            update()
        }else{
            save()
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate the textField with data from personManagedObject
        if personInfoManagedObject != nil {
            itemTextField.text = personInfoManagedObject.item
            priceTextField.text = personInfoManagedObject.price
        }
    }
    
    func update() {
        // collect the text field information to managed object
        personInfoManagedObject.item = itemTextField.text
        personInfoManagedObject.price = priceTextField.text
        
        // save context
        do {try context.save()  }
        catch{}
    }
    
    func save() {
        // make a new instance of personManagedObject
        let entity = NSEntityDescription.entity(forEntityName: "PeopleInfo", in: context)
        personInfoManagedObject = PeopleInfo(entity: entity!, insertInto: context)
        
        // collect the text field information to managed object
        personInfoManagedObject.item = itemTextField.text
        personInfoManagedObject.price = priceTextField.text

        // save context
        do {try context.save()  }
        catch{}
    }

}
