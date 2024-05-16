import UIKit

class AudibleListItemCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    func configure(with review: String) {
        titleLbl.text = review
        selectionStyle = .none
    }
}
