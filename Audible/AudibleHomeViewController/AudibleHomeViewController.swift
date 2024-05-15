import UIKit

struct HomeHeaderViewModel {
    let title: String
    let subtitle: String
}

struct BookCoversViewModel {
    let title: String
    let bookCovers: [BookCover]
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
                BookCover(image: .howWeLearn, title: "How We Learn", authors: ["Stanislas Dehaene"]),
                BookCover(image: .thinkingFastAndSlow, title: "Thinking, Fast and Slow", authors: ["Daniel Kahneman"]),
                BookCover(image: .talkingToStrangers, title: "Talking to Strangers", authors: ["Malcolm Gladwell"])
            ]
        ))
        
        rows.append(similarTitlesRow)
        
        let popularTitlesRow = Row.bookCovers(BookCoversViewModel(
            title: "Popular titles that you could also enjoy",
            bookCovers: [
                BookCover(image: .unstressable, title: "Unstressable", authors: ["Mo Gawdat", "Alice Law"]),
                BookCover(image: .liberatedLove, title: "Liberated Love", authors: ["Mark Groves", "Kylie McBeath"]),
                BookCover(image: .kokoro, title: "Kokoro", authors: ["Beth Kempton"]),
                BookCover(image: .threeSummers, title: "Three Summers", authors: ["Amra Sabic-El-Rayess", "Laura L. Sullivan"])
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
            
            return cell
        }
    }
}
