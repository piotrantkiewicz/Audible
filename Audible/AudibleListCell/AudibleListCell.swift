import UIKit

class AudibleListCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    func configure(with audibleList: AudibleList) {
        iconImageView.image = audibleList.image
        titleLbl.text = audibleList.title
    }
}
