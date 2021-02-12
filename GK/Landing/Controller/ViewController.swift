//
//  ViewController.swift
//  GK
//
//  Created by Oscar on 2021/02/12.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var questionsSearchBar: UISearchBar!
    @IBOutlet weak var quesetionsTableView: UITableView!
    
    private var questionsViewModel: QuestionsViewModel!
    private var dataSource: QuestionsTableViewDataSource<QuestionsTableViewCell,QuestionsData>!
    
    static var tag = String()
    var userSearchText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        userSearchText = searchText
        if searchText.count > 0 {
            searchBar.showsCancelButton = true
        } else {
            searchBar.showsCancelButton = false
        }
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        quesetionsTableView.isHidden = false
        ViewController.tag = userSearchText
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate() {
        self.questionsViewModel = QuestionsViewModel()
        self.questionsViewModel.bindQuestionsViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func configureSearchBar() {
        questionsSearchBar.delegate = self
        questionsSearchBar.searchTextField.backgroundColor = .white
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    func updateDataSource() {
        self.dataSource = QuestionsTableViewDataSource(cellIdentifier: "QuestionsTableViewCell", items: self.questionsViewModel.questionsData.items, configureCell: { (cell, qvm) in
            cell.questionsTitleLabel.text = qvm.title
            cell.numberOfVotesLabel.text = "\(String(describing: qvm.score)) Votes"
            cell.numberOfAnswers.text = "\(String(describing: qvm.answer_count)) answers"
            cell.numberOfViews.text = "\(String(describing: qvm.view_count)) views"
            cell.ownweNameLabel.text = "asked by \(String(describing: qvm.owner.display_name))"
            if qvm.is_answered == true {
                cell.tickImage.isHidden = false
                cell.owerNameLeadingConstraint.constant = 24
                cell.titleLeadingContraint.constant = 24
            } else {
                cell.tickImage.isHidden = true
                cell.owerNameLeadingConstraint.constant = 6
                cell.titleLeadingContraint.constant = 6
            }
        }, selectHandler: { (qvm) in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let questionDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "questionDetailViewController") as! QuestionDetailViewController
            questionDetailsViewController.question = qvm
            self.navigationController?.pushViewController(questionDetailsViewController, animated: true)
        })
        
        DispatchQueue.main.async {
            self.quesetionsTableView.dataSource = self.dataSource
            self.quesetionsTableView.delegate = self.dataSource
            self.quesetionsTableView.reloadData()
        }
    }
}
