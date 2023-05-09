//
//  TaskTableViewCell.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 5/3/23.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    var task: Task! {
        didSet {
            updateViews()
        }
    }
    
    var delegate: TaskTableViewCellDelegate?

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateViews() {
        statusButton.setImage(task.isCompleted ? ImageUtil.complete : ImageUtil.incomplete, for: .normal)
    }
    
    // MARK: Intents

    @IBAction func onCompletedButtonTapped(_ sender: Any) {
        print("tap registered")
        delegate?.taskTableViewCell(task: task)
    }
}
