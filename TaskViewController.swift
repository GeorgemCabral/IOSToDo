

import UIKit

class TaskViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var priority: UISegmentedControl!
    @IBOutlet weak var status: UISwitch!
    
    var task:Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let task = self.task {
            
            self.name.text = task.name
            self.priority.selectedSegmentIndex = self.setPriorityByIndex(letter: task.priority!)
            self.status.isOn = Bool(true)
        }
    
    }
    
    func setPriorityByIndex(letter: String) -> Int {
        if letter == "Baixa" {return 0}
        if letter == "Média" {return 1}
        else if letter == "Alta" {return 2}
        
        return 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Save" {
            if self.task == nil {
                self.task = TaskDB.instance.newTask()
            }
            
            self.task?.name = self.name.text
            self.task?.priority = setPriorityColor(index:self.priority.selectedSegmentIndex)
            self.task?.status = self.status.isOn
        }
     
    }
    
    
    func setPriorityColor(index:Int) -> String {
        if index == 0 {return "Baixa"}
        if index == 1 {return "Média"}
        
        return "Alta"
    }

}
