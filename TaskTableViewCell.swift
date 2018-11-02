

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priority: UIView!
    @IBOutlet weak var name: UILabel!
    var status:Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
  
    }
    
}


