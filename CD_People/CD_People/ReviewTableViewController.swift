

import UIKit
import CoreData

class ReviewTableViewController: UITableViewController , NSFetchedResultsControllerDelegate {
    
    // code data elements
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var reviewManagedObject : CartReview! = nil
    var entity : NSEntityDescription! = nil
    var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
    
    @IBAction func reviewBtn(_ sender: UIButton) {
        
    }
    
    func makeFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CartReview")
        
        let sorter = NSSortDescriptor(key: "user", ascending: true)
        
        //let predicate = NSPredicate(format: "%K == %@", "name", "milk")
        //request.predicate = predicate
        request.sortDescriptors = [sorter]
        return request
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make the frc object and then fetch data
        
        frc = NSFetchedResultsController(fetchRequest: makeFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do{try frc.performFetch()}
        catch{}
        
    }
    
    
    func controllerDidChangeContent(_ controller:NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return frc.sections![section].numberOfObjects
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
        
        // get the personManagedObject for indexPath
        reviewManagedObject = frc.object(at: indexPath) as! CartReview
        
        // Configure the cell...
        cell.textLabel?.text = reviewManagedObject.user
        cell.detailTextLabel?.text = reviewManagedObject.comment
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // get personManagedObject of indexpath and delete it
            reviewManagedObject = frc.object(at: indexPath) as! CartReview
            context.delete(reviewManagedObject)
            
            // context save
            do{try context.save()}
            catch{}
            
            // frc perform fetch
            do{try frc.performFetch()}
            catch{}
            
            // reload
            tableView.reloadData()
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    /// MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segue" {
            
            // get personManagedObject from sender
            let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
            reviewManagedObject = frc.object(at: indexPath!) as! CartReview
            
            // Get the new view controller using segue.destinationViewController.
            let destination = segue.destination as! AddUpdateDeleteReviewViewController
            
            // Pass the selected object to the new view controller.
            destination.reviewManagedObject = reviewManagedObject
        }
        else if segue.identifier == "singlereview" {
            // Get the new view controller using segue.destinationViewController.
            _ = segue.destination as! AddUpdateDeleteReviewViewController
            
        }
        
    }
    
}
