

import UIKit
import CoreData

class PeopleTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    // code data elements
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var personInfoManagedObject : PeopleInfo! = nil
    var entity : NSEntityDescription! = nil
    var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
    
    
    
    @IBAction func addtoCartBtn(_ sender: UIButton) {
    }
    
    func makeFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PeopleInfo")
        
        let sorter = NSSortDescriptor(key: "item", ascending: true)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // get the personManagedObject for indexPath
        personInfoManagedObject = frc.object(at: indexPath) as! PeopleInfo
        
        // Configure the cell...
        cell.textLabel?.text = personInfoManagedObject.item
        cell.detailTextLabel?.text = personInfoManagedObject.price

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
            personInfoManagedObject = frc.object(at: indexPath) as! PeopleInfo
            context.delete(personInfoManagedObject)
            
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cellSegue" {
            
            // get personManagedObject from sender
            let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
            personInfoManagedObject = frc.object(at: indexPath!) as! PeopleInfo
            
            // Get the new view controller using segue.destinationViewController.
            let destination = segue.destination as! AddPersonViewController
            
            // Pass the selected object to the new view controller.
            destination.personInfoManagedObject = personInfoManagedObject
        }
        else if segue.identifier == "add" {
        // Get the new view controller using segue.destinationViewController.
            _ = segue.destination as! AddPersonViewController
            
        }
        
    }
    

}
