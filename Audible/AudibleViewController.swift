import UIKit

class AudibleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var lists: [AudibleList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lists = myAudibleList()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let cellName = "AudibleListCell"
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.rowHeight = 44
    }
    
    func present(with audibleList: AudibleList) {
        let audibleListViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "AudibleListViewController") as! AudibleListViewController
        
        audibleListViewController.modalPresentationStyle = .fullScreen
        
        audibleListViewController.audibleList = audibleList
        
        present(audibleListViewController, animated: true)
    }
    
    private func myAudibleList() -> [AudibleList] {
        var lists = [AudibleList]()
        
        lists.append(AudibleList(
            image: .whyWeSleep,
            title: "Why We Sleep",
            description: "Unlocking the Power of Sleep and Dreams",
            reviews: whyWeSleepReviews()
        ))
        
        lists.append(AudibleList(
            image: .dopamineNation,
            title: "Dopamine Nation",
            description: "Finding Balance in the Age of Indulgence",
            reviews: dopamineNationReviews()
        ))
        
        lists.append(AudibleList(
            image: .startWithWhy,
            title: "Start with Why",
            description: "How Great Leaders Inspire Everyone to Take Action",
            reviews: startWithWhyReviews()
        ))
        
        return lists
    }
    
    private func whyWeSleepReviews() -> [String] {
        var reviews = [String]()
        reviews.append("Amazingly informative, unfitting reader")
        reviews.append("In-depth sleep analysis that fails to grasp")
        reviews.append("A must read if you want to live longer")
        reviews.append("That Narrator!!!")
        reviews.append("An eye-opener")
        reviews.append("We don't sleep enough. Here's how.")
        reviews.append("Un libro genial")
        
        
        return reviews
    }
    
    private func dopamineNationReviews() -> [String] {
        var reviews = [String]()
        reviews.append("Brilliant core message!")
        reviews.append("super")
        reviews.append("Nice Explanation about Addiction")
        reviews.append("Pleasure and pain; honesty and balance")
        reviews.append("Great Book")
        reviews.append("A very good read with great story telling")
        reviews.append("Verständlich, eindringlich und nachhaltig")
        
        return reviews
    }
    
    private func startWithWhyReviews() -> [String] {
        var reviews = [String]()
        reviews.append("Very good message, but highly repetitive")
        reviews.append("es wiederholt sich, aber")
        reviews.append("amazing book")
        reviews.append("Listen and learn")
        reviews.append("Gut, aber hinten raus repititiv")
        reviews.append("A worthy book.")
        
        return reviews
    }
}

extension AudibleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "AudibleListCell") as? AudibleListCell
        else { return UITableViewCell() }
        
        let todoList = lists[indexPath.row]
        
        cell.configure(with: todoList)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension AudibleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoList = lists[indexPath.row]
        present(with: todoList)
    }
}
