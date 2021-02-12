//
//  QuestionsTableViewCell.swift
//  GK
//
//  Created by Oscar on 2021/02/12.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionsTitleLabel: UILabel!
    @IBOutlet weak var ownweNameLabel: UILabel!
    @IBOutlet weak var numberOfVotesLabel: UILabel!
    @IBOutlet weak var numberOfAnswers: UILabel!
    @IBOutlet weak var numberOfViews: UILabel!
    @IBOutlet weak var tickImage: UIImageView!
    @IBOutlet weak var owerNameLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLeadingContraint: NSLayoutConstraint!
    
    var question : QuestionsData? {
        didSet {
            questionsTitleLabel.text = question?.title
            numberOfVotesLabel.text = "\(String(describing: question?.score)) Votes"
            numberOfAnswers.text = "\(String(describing: question?.answer_count)) answers"
            numberOfViews.text = "\(String(describing: question?.view_count)) views"
            ownweNameLabel.text = "asked by \(String(describing: question?.owner.display_name))"
            if question?.is_answered == true {
                tickImage.isHidden = false
                owerNameLeadingConstraint.constant = 24
                titleLeadingContraint.constant = 24
            } else {
                tickImage.isHidden = true
                owerNameLeadingConstraint.constant = 6
                titleLeadingContraint.constant = 6
            }
        }
    }
}
