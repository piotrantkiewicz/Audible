import UIKit

class HomeHeaderCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewmodel: HomeHeaderViewModel) {
        self.titleLbl.text = viewmodel.title
        self.subTitleLbl.text = viewmodel.subtitle
    }
}
