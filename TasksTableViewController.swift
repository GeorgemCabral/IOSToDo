
//

import UIKit

class TasksTableViewController: UITableViewController {
    let section = ["To Do", "Done"]
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.tasks = TaskDB.instance.allTasks()
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
  
    
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 2
    }
    
   
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.section[section]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int = 0
        
        if (section == 0) {
            for _ in self.tasks{
                if tasks.contains(where: {$0.status==false}){
                    count += 1
                }
            }
        }else{
            for _ in self.tasks{
                if tasks.contains(where: {$0.status==true}){
                    count += 1
                }
            }
        }
        
        return count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        print()

       
        if tasks.contains(where: {$0.status == Bool(truncating: indexPath.section as NSNumber)}){
            cell.name.text = self.tasks[indexPath.row].name!
            cell.priority.backgroundColor = self.setPriorityColor(index:self.tasks[indexPath.row].priority!)
            cell.status = self.tasks[indexPath.row].status
        }
        

        
        return cell
    }
    
    @IBAction func unwindToTaskList(segue:UIStoryboardSegue) -> Void {
       
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if let svc = segue.source as? TaskViewController {
                self.tasks[indexPath.row] = svc.task!
                self.tableView.reloadData()
                
                TaskDB.instance.saveContext()
            }
            print("bbb")
        } else if(segue.identifier == "Save") {
            print("aaaa")
            if let svc = segue.source as? TaskViewController {
                if let task = svc.task {
                    self.tasks.append(task)
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          
            let toRemove = self.tasks.remove(at: indexPath.row)
            
            TaskDB.instance.delete(task: toRemove)
            TaskDB.instance.saveContext()
            
            
            tableView.reloadData()
        } else if editingStyle == .insert {
         
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if(segue.identifier == "Edit") {
            
            if let dvc = segue.destination as? TaskViewController {
                let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
                let task = self.tasks[indexPath!.row]
                
                dvc.task = task
                
                
            }
        }
    }
    
    func setPriorityColor(index:String) -> UIColor {
        var color = UIColor.red
        
        if index == "Baixa" {color = UIColor.green}
        if index == "Média" {color = UIColor.orange}
        
        return color
    }
    
    func setPriorityByIndex(letter: String) -> Int {
        if letter == "Baixa" {return 0}
        if letter == "Média" {return 1}
        else if letter == "Alta" {return 2}
        
        return 0
    }
    
}

