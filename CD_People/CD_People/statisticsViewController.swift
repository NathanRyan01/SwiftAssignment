

import UIKit
import CoreData

class statisticsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var historyManagedObject : HistoryInfo! = nil
    var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
    var avg: Double = 0.0
    var total: Double = 0.0
    var purchase: Double = 0.0
    var items: Int = 0
    var value: String = ""
    var counter = true
    
    
    
    @IBOutlet weak var purchaseLabel: UILabel!
    @IBOutlet weak var purchaseValue: UILabel!
    
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var avgValue: UILabel!

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gatherStats()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func convertBtn(_ sender: UIButton) {
        
        if(sender.currentTitle == "Pound" && counter){
            counter = false
            avg = avg * 0.9
            total = total * 0.9
            avgValue?.text = String(avg)
            totalValue?.text = String(total)
        }
        else if (sender.currentTitle == "Euro" && (!counter)){
            counter = true
            avg = floor(avg * 1.12)
            total = floor(total * 1.12)
            avgValue?.text = String(avg)
            totalValue?.text = String(total)
        }
    }
    
    
    func gatherStats(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryInfo")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                if(result.count == 0){
                    break;
                }
                else{
                    purchase = purchase + 1.0
                    items = items + 1
                    value = (data.value(forKey: "price") as! String)
                    total += Double(value)!
             }
            }
            avg = total/purchase
            purchaseValue?.text = String(items)
            avgValue?.text = String(avg)
            totalValue?.text = String(total)
            
        } catch{
            print("Not working")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
  //  }

}
