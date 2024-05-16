import UIKit

struct AudibleList {
    let image: UIImage
    let title: String
    let description: String
    var reviews: [String]
    let rating: String
}

class AudibleListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addReviewView: UIView!
    @IBOutlet weak var addReviewSafeAreaView: UIView!
    @IBOutlet weak var addReviewSaveAreaViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var postBtn: UIButton!
    
    var audibleList: AudibleList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureKeyboard()
        configureAddReviewView()
        configureTextField()
        setAddNewReviewButton(enabled: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureTextField() {
        textField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
    }
    
    private var isNewReviewValid: Bool {
        guard let text = textField.text else { return false }
        return !text.isEmpty && text.count >= 4
    }
    
    @objc private func didChangeText() {
        setAddNewReviewButton(enabled: isNewReviewValid)
    }
    private func setAddNewReviewButton(enabled isEnabled:Bool) {
        postBtn.isPointerInteractionEnabled = isEnabled
        postBtn.tintColor = isEnabled ? .tintColor : .gray.withAlphaComponent(0.5)
    }
    
    private func configureAddReviewView() {
        addReviewView.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        addReviewView.layer.shadowOffset = .zero
        addReviewView.layer.shadowRadius = 18.2
        addReviewView.layer.shadowPath = UIBezierPath(roundedRect: addReviewView.bounds, cornerRadius: addReviewView.layer.cornerRadius).cgPath
        addReviewView.layer.shadowOpacity = 1
    }
    
    private func configureKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        let isKeyboardHidden = endFrame.origin.y >= UIScreen.main.bounds.size.height
        
        if isKeyboardHidden {
            addReviewSaveAreaViewBottomConstraint.constant = 0
            tableViewBottomConstraint.constant = 0
        } else {
            addReviewSaveAreaViewBottomConstraint.constant = -endFrame.height + view.safeAreaInsets.bottom - 8
            tableViewBottomConstraint.constant = endFrame.height + 8 + addReviewSafeAreaView.frame.height
        }
        
        UIView.animate(withDuration: duration) {
            self.postBtn.alpha = isKeyboardHidden ? 0 : 1
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.tableView.scrollToRow(at: IndexPath(row: self.audibleList.reviews.count - 1, section: 1), at: .bottom, animated: true)
        }
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
    
    @IBAction func plusBtnTapped(_ sender: Any) {
        becomeFirstResponder()
    }
    
    @IBAction func postBtnTapped(_ sender: Any) {
        guard isNewReviewValid, let text = textField.text else { return }
        
        let itemTrimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        audibleList.reviews.append(itemTrimmed)
        
        let indexPath = IndexPath(row: audibleList.reviews.count - 1, section: 1)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        textField.text = ""
        setAddNewReviewButton(enabled: false)
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

extension AudibleListViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
