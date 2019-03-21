//
//  ContactsListViewController.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/11/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol ContactListProtocol: class {
    func hideLoadingView()
    func displayLoadingView()
    func displayError(_ message: String)
    func displayTransactionRecipt(_ transaction: TransactionViewModel)
    func displayUsers(_ list: [UserViewModel])
}

class ContactsListViewController: BaseViewController {
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var reciptView: ReciptView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var reciptContainerView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    var interactor: ContactListInteractor?
    var tableViewData: [UserViewModel] = []
    
    let maxHeight: CGFloat = 175
    let minHeight: CGFloat = 100
    var previousScrollOffset: CGFloat = 0
    
    
    private var currentState: PopupState = .closed
    private var runningAnimators = [UIViewPropertyAnimator]()
    private var animationProgress = [CGFloat]()
    private let popupBottonOffset: CGFloat = 540
    
    init(interactor: ContactListInteractor) {
        super.init(nibName: "ContactsListViewController", bundle: Bundle.main)
        self.interactor = interactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configViews()
        interactor?.getUsersList()
    }

    private func configViews() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tryAgainButton.layer.cornerRadius = 25
        self.headerView.setDelegate(delegate: self)
        self.headerHeightConstraint.constant = self.maxHeight
        
        registerTableViewCells()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        headerView.addGestureRecognizer(tap)
        
        let reciptGesture: InstantPanGestureRecognizer = InstantPanGestureRecognizer(target: self, action: #selector(self.popupViewPanned(recognizer:)))
        reciptContainerView.addGestureRecognizer(reciptGesture)
    }
    
    private func registerTableViewCells() {
        self.tableView.register(UINib(nibName: "ContactListCell", bundle: nil), forCellReuseIdentifier: "ContactListCell")
    }
    
    @objc private func dismissKeyboard() {
        headerView.searchbar.resignFirstResponder()
    }
    
    @IBAction func tryAgainButtonPressed(_ sender: Any) {
        interactor?.getUsersList()
    }
}

extension ContactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath) as? ContactListCell else {
            return UITableViewCell()
        }
        
        cell.setContent(user: tableViewData[indexPath.row])
        
        return cell
    }
}

extension ContactsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissKeyboard()
        AppRouter.shared.routeToNewCard(user: tableViewData[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        if canAnimateHeader(self.tableView) {
            var newHeight = self.headerHeightConstraint.constant
            
            if isScrollingDown {
                newHeight = max(self.minHeight, self.headerHeightConstraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(self.maxHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
            }
        
            if newHeight != self.headerHeightConstraint.constant {
                self.headerHeightConstraint.constant = newHeight
                self.setScrollPosition(position: self.previousScrollOffset)
            }
        }
        
        self.previousScrollOffset = scrollView.contentOffset.y
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
    }
    
    func scrollViewDidStopScrolling() {
        let range = self.maxHeight - self.minHeight
        let midPoint = self.minHeight + (range / 2)
        
        if self.headerHeightConstraint.constant > midPoint {
            expandHeader()
        } else {
            collapseHeader()
        }
    }
    
    private func collapseHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.minHeight
            self.view.layoutIfNeeded()
        })
    }
    
    private func expandHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeight
            self.view.layoutIfNeeded()
        })
    }
    
    private func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - self.minHeight
        
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    private func setScrollPosition(position: CGFloat) {
        self.tableView.contentOffset = CGPoint(x: self.tableView.contentOffset.x, y: position)
    }
}

extension ContactsListViewController: ContactListProtocol {
    func hideLoadingView() {
        self.hideLoader()
    }
    
    func displayLoadingView() {
        self.showLoader()
    }
    
    func displayError(_ message: String) {
        errorView.isHidden = false
        tableView.isHidden = true
        headerView.searchbar.isEnabled = false
        
        errorMessage.text = message
    }
    
    func displayUsers(_ list: [UserViewModel]) {
        errorView.isHidden = true
        tableView.isHidden = false
        headerView.searchbar.isEnabled = true
        
        self.tableViewData = list
        self.tableView.reloadData()
    }
    
    func displayTransactionRecipt(_ transaction: TransactionViewModel) {
        reciptView.setContent(transaction)
        openReciptPopup()
    }
}

extension ContactsListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        interactor?.searchUsers(name: updatedString ?? "")
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        headerView.searchbar.changeLayoutBy(state: .active)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        headerView.searchbar.changeLayoutBy(state: .inactive)
    }
}

extension ContactsListViewController {
    
    @objc private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animateTransitionIfNeeded(to: currentState.opposite, duration: 1)
            runningAnimators.forEach { $0.pauseAnimation() }
            animationProgress = runningAnimators.map { $0.fractionComplete }
            
        case .changed:
            let translation = recognizer.translation(in: reciptContainerView)
            var fraction = -translation.y / popupBottonOffset
            
            if currentState == .open { fraction *= -1 }
            if runningAnimators[0].isReversed { fraction *= -1 }
            
            for (index, animator) in runningAnimators.enumerated() {
                animator.fractionComplete = fraction + animationProgress[index]
            }
            
        case .ended:
            let yVelocity = recognizer.velocity(in: reciptContainerView).y
            let shouldClose = yVelocity > 0
            
            if yVelocity == 0 {
                runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
                break
            }
            
            switch currentState {
            case .open:
                if !shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            case .closed:
                if shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if !shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            }
            
            runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
            
        default:
            ()
        }
    }
    
    private func animateTransitionIfNeeded(to state: PopupState, duration: TimeInterval) {
        
        guard runningAnimators.isEmpty else { return }
        
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomConstraint.constant = 0
                self.reciptContainerView.layer.cornerRadius = 20
                self.overlayView.isHidden = false
                self.overlayView.alpha = 0.7
            case .closed:
                self.bottomConstraint.constant = -self.popupBottonOffset
                self.reciptContainerView.layer.cornerRadius = 0
                self.overlayView.alpha = 0
            }
            self.view.layoutIfNeeded()
        })
        
        transitionAnimator.addCompletion { position in
            
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            }
            
            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = -self.popupBottonOffset
                self.overlayView.isHidden = true
            }
            
            self.runningAnimators.removeAll()
            
        }
        
        transitionAnimator.startAnimation()

        runningAnimators.append(transitionAnimator)
    }
    
    private func openReciptPopup() {
        animateTransitionIfNeeded(to: PopupState.open, duration: 1)
    }
}

