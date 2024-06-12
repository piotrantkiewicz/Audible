import UIKit

struct HomeHeaderViewModel {
    let title: String
    let subtitle: String
}

struct BookCoversViewModel {
    let title: String
    let bookCovers: [Book]
}

class AudibleHomeViewController: UIViewController {
    
    enum Row {
        case homeHeader(HomeHeaderViewModel)
        case bookCovers(BookCoversViewModel)
    }
    
    @IBOutlet weak var tableView: UITableView!

    var rows: [Row] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillDataSource()
        configureTableView()
    }
    
    private func fillDataSource() {
        
        let homeHeatherRow = Row.homeHeader(HomeHeaderViewModel(
            title: "Good afternoon, Ann",
            subtitle: "You have 5 credits"
        ))
        
        rows.append(homeHeatherRow)
        
        let similarTitlesRow = Row.bookCovers(BookCoversViewModel(
            title: "Similar titles you have listened to",
            bookCovers: [
                Book(imageName: "howWeLearn", title: "How We Learn", description: "How We Learn as it's meant to be heard", authors: ["Stanislas Dehaene"], reviews: [], rating: "4.3", priceCredit: 1),
                Book(imageName: "thinkingFastAndSlow", title: "Thinking, Fast and Slow", description: "", authors: ["Daniel Kahneman"], reviews: [], rating: "", priceCredit: 2),
                Book(imageName: "talkingToStrangers", title: "Talking to Strangers", description: "", authors: ["Malcolm Gladwell"], reviews: [], rating: "", priceCredit: 3)
            ]
        ))
        
        rows.append(similarTitlesRow)
        
        let popularTitlesRow = Row.bookCovers(BookCoversViewModel(
            title: "Popular titles that you could also enjoy",
            bookCovers: [
                Book(imageName: "unstressable", title: "Unstressable", description: "", authors: ["Mo Gawdat", "Alice Law"], reviews: [], rating: "", priceCredit: 4),
                Book(imageName: "liberatedLove", title: "Liberated Love", description: "", authors: ["Mark Groves", "Kylie McBeath"], reviews: [], rating: "", priceCredit: 5),
                Book(imageName: "kokoro", title: "Kokoro", description: "", authors: ["Beth Kempton"], reviews: [], rating: "", priceCredit: 6),
                Book(imageName: "threeSummers", title: "Three Summers", description: "", authors: ["Amra Sabic-El-Rayess", "Laura L. Sullivan"], reviews: [], rating: "", priceCredit: 7)
            ]
        ))
        
        rows.append(popularTitlesRow)
        
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeHeaderCell", bundle: nil), forCellReuseIdentifier: "HomeHeaderCell")
        tableView.register(UINib(nibName: "HomeBookCoversCell", bundle: nil), forCellReuseIdentifier: "HomeBookCoversCell")
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension AudibleHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch rows[indexPath.row] {
        case .homeHeader(let viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeHeaderCell") as! HomeHeaderCell
            cell.configure(with: viewModel)
            
            return cell
            
        case .bookCovers(let viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeBookCoversCell") as! HomeBookCoversCell
            cell.configure(with: viewModel)
            
            cell.didSelectBook = { [weak self] book in
                self?.present(book)
    
            }
            
            return cell
        }
    }
}

extension AudibleHomeViewController: UITableViewDelegate {
    private func present(_ book: Book) {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "AudibleListViewController") as! AudibleListViewController
        
        viewController.modalPresentationStyle = .fullScreen
        
        viewController.viewModel = AudibleListViewModel(book: book)
        
        present(viewController, animated: true)
    }
}
