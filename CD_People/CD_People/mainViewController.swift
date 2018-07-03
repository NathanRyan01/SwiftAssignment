
import UIKit
import CoreData
import AVFoundation

class mainViewController: UIViewController{

    var audioplayer = AVAudioPlayer()
    
    @IBAction func historyBtn(_ sender: UIButton) {
        
    }
    
    
    @IBAction func detailsBtn(_ sender: UIButton) {
        
    }
    
    
    @IBAction func cartBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func reviewBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func musicBtn(_ sender: UIButton) {
        
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var personInfoManagedObject : PeopleInfo! = nil
    var historyManagedObject : HistoryInfo! = nil
    var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
    
    @IBAction func compPurchaseBtn(_ sender: UIButton) {
        self.purchase()
    }
    
    func purchase(){
        let entityHistory = NSEntityDescription.entity(forEntityName: "HistoryInfo", in: context)
        historyManagedObject = HistoryInfo(entity: entityHistory!, insertInto: context)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PeopleInfo")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                historyManagedObject?.item = (data.value(forKey:"item") as! String)
                historyManagedObject?.price = (data.value(forKey:"price") as! String)
                do{try context.save()}
                catch{}
                
            }
            for res in result {
                context.delete(res as! NSManagedObject)
                do{try context.save()}
                catch{}
            }
        } catch{
            print("Error")
        }
        self.alert()
    }
    
    func alert(){
        let alert = UIAlertController(title: "Purchase Completed", message: "If you wish to see your purchsed items, then go to the History screen", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cart" {
            
            // Get the new view controller using segue.destinationViewController.
            _ = segue.destination as! PeopleTableViewController

        }
        else if segue.identifier == "history" {
            
            // Get the new view controller using segue.destinationViewController.
            _ = segue.destination as! HistoryTableViewController
            
        }
        else if segue.identifier == "stats"  {
            
            // Get the new view controller using segue.destinationViewController.
            _ = segue.destination as! statisticsViewController
            
        }
        else if segue.identifier == "review"  {
            
            // Get the new view controller using segue.destinationViewController.
            _ = segue.destination as! ReviewTableViewController
            
        }
        else if segue.identifier == "music"  {
            
            // Get the new view controller using segue.destinationViewController.
            _ = segue.destination as! PlayMusicViewController
            
        }
        
        
    }

}
