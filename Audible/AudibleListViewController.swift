import UIKit

struct AudibleList {
    let image: UIImage
    let title: String
    let description: String
    let reviews: [String]
}

class AudibleListViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var audibleList: AudibleList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.layer.cornerRadius = 22
        playButton.clipsToBounds = true
        
        configure()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        let cellName = "AudibleListItemCell"
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
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

extension AudibleListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        audibleList.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudibleListItemCell") as? AudibleListItemCell
        else { return UITableViewCell() }
        
        let review = audibleList.reviews[indexPath.row]
        cell.configure(with: review)
        
        return cell
    }
}
