//
//  QuestionDetailViewController.swift
//  GK
//
//  Created by Oscar on 2021/02/12.
//

import UIKit

class QuestionDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var dateAskedLabel: UILabel!
    @IBOutlet weak var profilePictureImage: UIImageView!
    var question : QuestionsData?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureFooter()
        setUpQuestionData()
        addTags()
        getDate()
        getProfileImage()
    }
}

extension QuestionDetailViewController {
    func configureNavigation() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 64/255, green: 120/255, blue: 196/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationItem.title = "Question"
    }
    
    func configureFooter() {
        footerView.layer.borderWidth = 0.5
        footerView.layer.borderColor = UIColor.black.cgColor
    }
    
    func setUpQuestionData() {
        let questionBody = question?.body
        titleLabel.text = question?.title
        ownerLabel.text = question?.owner.display_name
        reputationLabel.text = "\(String(describing: question?.owner.reputation ?? 0))"
        questionTextView.attributedText = questionBody?.htmlToAttributedString
    }
    
    func getDate() {
        let dateTime = question?.creation_date ?? 0
        let timeInterval = Double(dateTime)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        dateAskedLabel.text = "asked \(myNSDate)"
    }
    
    func addTags() {
        let tagsArray = question?.tags
        tagLabel.text = tagsArray?.joined(separator: ", ")
    }
    
    func getProfileImage() {
        let url = URL(string: question?.owner.profile_image ?? "")
        let data = try? Data(contentsOf: url!)
        profilePictureImage.image = UIImage(data: data!)
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
