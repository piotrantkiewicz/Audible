import UIKit

struct AudibleList {
    let image: UIImage
    let title: String
    let description: String
    let reviews: [String]
    let rating: String
}

class AudibleListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var audibleList: AudibleList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let cellName = "AudibleListItemCell"
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.register(UINib(nibName: "AudibleBookDetailsCell", bundle: nil), forCellReuseIdentifier: "AudibleBookDetailsCell")
    }

    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension AudibleListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            return audibleList.reviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudibleBookDetailsCell") as? AudibleBookDetailsCell else { return UITableViewCell() }
            cell.configure(with: audibleList)
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudibleListItemCell") as? AudibleListItemCell
            else { return UITableViewCell() }
            
            let review = audibleList.reviews[indexPath.row]
            cell.configure(with: review)
            
            return cell
        }
    }
}

extension AudibleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 391
        default:
            return 44
        }
    }
}
