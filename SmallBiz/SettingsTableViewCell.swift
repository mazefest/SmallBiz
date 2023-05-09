//
//  SettingsTableViewCell.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 5/3/23.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingsSwitch: UISwitch!
    
    var item: SettingsItem! {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: SettingChangedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func settingToggled(_ sender: Any) {
        delegate?.settingToggled(item: item)
    }
    
    func updateViews() {
        self.reloadInputViews()
    }
}
