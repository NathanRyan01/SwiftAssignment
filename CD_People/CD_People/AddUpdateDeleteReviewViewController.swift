

import UIKit
import CoreData


class AddUpdateDeleteReviewViewController: UIViewController {


    @IBOutlet weak var userField: UITextField!
    
    @IBOutlet weak var commentBox: UITextView!
    
    @IBOutlet weak var animationView: UIView!
    
    
    
    var textString = "Please enter a positive review"
    
    @IBAction func animationBtn(_ sender: UIButton) {
        let myTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 380.00, height: 40.00));
        UIView.animate(withDuration: 1.5, animations: {
            self.animationView.backgroundColor = .brown
            self.animationView.frame.size.width += 15
            self.animationView.frame.size.height += 15
        }) { _ in
            UIView.animate(withDuration: 1, delay: 0.5, options: [.autoreverse, .repeat], animations: {
                self.animationView.addSubview(myTextField)
                self.animationView.frame.origin.y -= 30
                myTextField.backgroundColor = UIColor.gray
                myTextField.text = self.textString
                myTextField.borderStyle = UITextBorderStyle.line
            })
        }
    }
    @IBAction func addUpdate(_ sender: UIButton) {
        // either save or update
        if reviewManagedObject != nil {
            update()
        }else{
            save()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    //code data objects
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var reviewManagedObject : CartReview! = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Populate the textField with data from personManagedObject
        if reviewManagedObject != nil {
           userField.text = reviewManagedObject.user
           commentBox.text = reviewManagedObject.comment
        }
    }
    
    
    
    func update() {
        // collect the text field information to managed object
        reviewManagedObject.user = userField.text
        reviewManagedObject.comment = commentBox.text
        
        // save context
        do {try context.save()  }
        catch{}
    }
    
    func save() {
        // make a new instance of personManagedObject
        let entity = NSEntityDescription.entity(forEntityName: "CartReview", in: context)
        reviewManagedObject = CartReview(entity: entity!, insertInto: context)
        
        // collect the text field information to managed object
        reviewManagedObject.user = userField.text
        reviewManagedObject.comment = commentBox.text
        
        // save context
        do {try context.save()  }
        catch{}
    }
    
    
}
