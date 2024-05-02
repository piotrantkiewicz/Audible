import UIKit

struct AudibleList {
    let image: UIImage
    let title: String
    let description: String
}

class AudibleListViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var audibleList: AudibleList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.layer.cornerRadius = 22
        playButton.clipsToBounds = true
        
        configure()
    }
    
    func configure() {
        imageView.image = audibleList.image
        titleLbl.text = audibleList.title
        descriptionLbl.text = audibleList.description
    }
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
