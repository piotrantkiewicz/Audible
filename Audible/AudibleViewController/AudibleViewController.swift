import UIKit

class AudibleViewModel {
    
    private let repository: BookListRepository
    
    var bookLists: [AudibleList] = []
    
    var didFetchLists: (() -> ())
    
    init(repository: BookListRepository = BookListRepository(), didFetchLists: @escaping (() -> ())) {
        self.repository = repository
        self.didFetchLists = didFetchLists
    }
    
    func fetchBooks() {
        Task {
            do {
                let result = try await repository.fetchBookList()
                self.bookLists = result
                
                await MainActor.run {
                    self.didFetchLists()
                }
                
            } catch {
                print(error)
            }
        }
    }
}

class AudibleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel = AudibleViewModel(
        didFetchLists: { [weak self] in
            self?.tableView.reloadData()
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        
        viewModel.fetchBooks()
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
    
    @IBAction func homeBtnTapped(_ sender: Any) {
        let audibleHomeViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "AudibleHomeViewController") as! AudibleHomeViewController
        
        audibleHomeViewController.modalPresentationStyle = .fullScreen
        
        present(audibleHomeViewController, animated: true)
    }
    
}

extension AudibleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.bookLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "AudibleListCell") as? AudibleListCell
        else { return UITableViewCell() }
        
        let todoList = viewModel.bookLists[indexPath.row]
        
        cell.configure(with: todoList)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension AudibleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoList = viewModel.bookLists[indexPath.row]
        present(with: todoList)
    }
}
