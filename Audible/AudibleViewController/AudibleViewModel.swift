import Foundation

class AudibleViewModel {
    
    private let repository: BookListRepository
    
    var bookLists: [Book] = []
    
    var didFetchLists: (() -> ())?
    
    init(repository: BookListRepository = BookListRepositoryLive(), didFetchLists: @escaping (() -> ())) {
        self.repository = repository
        self.didFetchLists = didFetchLists
    }
    
    func fetchBooks() {
        Task {
            do {
                let result = try await repository.fetchBookList()
                self.bookLists = result.sorted(by: { $0.title < $1.title })
                await MainActor.run {
                    self.didFetchLists?()
                }
                
            } catch {
                print(error)
            }
        }
    }
}
