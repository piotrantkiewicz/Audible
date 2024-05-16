import UIKit

class AudibleBookDetailsCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playButton.layer.cornerRadius = 22
        playButton.clipsToBounds = true
    }
    
    func configure(with audibleList: AudibleList) {
        bookImageView.image = audibleList.image
        titleLbl.text = audibleList.title
        subTitleLbl.text = audibleList.description
    }
}
