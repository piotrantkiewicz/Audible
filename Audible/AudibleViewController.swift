import UIKit

class AudibleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func present(with audibleList: AudibleList) {
        let audibleListViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "AudibleListViewController") as! AudibleListViewController
        
        audibleListViewController.modalPresentationStyle = .fullScreen
        
        audibleListViewController.audibleList = audibleList
        
        present(audibleListViewController, animated: true)
    }
    
    @IBAction func whyWeSleepTapped(_ sender: Any) {
        present(with: AudibleList(
            image: .whyWeSleep,
            title: "Why We Sleep",
            description: "Unlocking the Power of Sleep and Dreams"))
    }
    
    @IBAction func dopamineNationTapped(_ sender: Any) {
        present(with: AudibleList(
            image: .dopamineNation,
            title: "Dopamine Nation",
            description: "Finding Balance in the Age of Indulgence"))
    }
    
    @IBAction func startWithWhyTapped(_ sender: Any) {
        present(with: AudibleList(
            image: .startWithWhy,
            title: "Start with Why",
            description: "How Great Leaders Inspire Everyone to Take Action"))
    }
}
