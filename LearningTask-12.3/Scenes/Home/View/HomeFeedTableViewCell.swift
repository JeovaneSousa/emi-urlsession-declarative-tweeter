//
//  HomeFeedTableViewCell.swift
//  LearningTask-12.3
//
//  Created by Jeovane Barbosa on 22/01/23.
//

import UIKit

class HomeFeedTableViewCell: UITableViewCell {
    
    static var identifier = String(describing: HomeFeedTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViewCode()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var post: FeedPost? {
        didSet {
            guard let post = post else {return}
            profileImageView.setImageByDowloading(url: post.author.profilePictureURL)
            nameLabel.text = post.author.fullName
            userNameLabel.text = post.author.username
            postTextLabel.text = post.textContent
            timeLabel.text = Date.now.getFormattedTimeInterval(since: DateFormatter.format(stringDate: post.createdAt, customPattern: .dateAndTime))
            likeActionButton.count = String(describing: post.loves)
            retweetsActionButton.count = String(describing: post.reposts)
            commentActionButton.count = String(describing: post.replies)
            
            titleStackView.isHidden = false
            retweetView.isHidden = true
            
            guard post.isReposting else {return}
            retweetProfileImageView.setImageByDowloading(url: post.reposting!.author.profilePictureURL)
            retweetNameLabel.text = post.reposting?.author.fullName
            retweetUserNameLabel.text = post.reposting?.author.username
            retweetTimeLabel.text = Date.now.getFormattedTimeInterval(since: DateFormatter.format(stringDate: post.reposting!.createdAt, customPattern: .dateAndTime))
            retweetPostTextLabel.text = post.reposting?.textContent
            
            retweetView.isHidden = false
            titleStackView.isHidden = true
        }
    }
//-----------------------------------------------------------------//
//MARK: - Implements Post Cell
//-----------------------------------------------------------------//
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .firstBaseline
        stackView.spacing = 12
        stackView.isLayoutMarginsRelativeArrangement =  true
        stackView.layoutMargins = .init(top: 12, left: 20, bottom: 12, right: 20)
        
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(postStackView)
        
        return stackView
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .quaternaryLabel
        imageView.layer.cornerRadius = 25
        
        return imageView
    }()
    
    lazy var postStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        
        stackView.addArrangedSubview(titleStackView)
        stackView.addArrangedSubview(postTextLabel)
        stackView.addArrangedSubview(retweetView)
        stackView.addArrangedSubview(actionsStackView)
        
        return stackView
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.alignment = .fill
        stackview.spacing = 4
        
        stackview.addArrangedSubview(nameLabel)
        stackview.addArrangedSubview(userNameLabel)
        stackview.addArrangedSubview(dotLabel)
        stackview.addArrangedSubview(timeLabel)
        
        return stackview
    }()
    
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "<Nome do autor do Post>"
        
        return label
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.text = "<Nome do usuàrio do Post>"
        
        return label
    }()
    
    lazy var dotLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.textColor = .secondaryLabel

        label.text = "."
        
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.text = "<Tempo>"
        
        return label
    }()
    
    lazy var postTextLabel: UILabel = {
        let label = UILabel()
        translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "<Texto do Post>"
        
        return label
    }()
    
//-----------------------------------------------------------------//
//MARK: - Implements RetweetView
//-----------------------------------------------------------------//
    lazy var retweetView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.quaternaryLabel.cgColor
        view.isHidden = true
        
        view.addSubview(retweetContainerStackView)
        
        return view
    }()
    
    lazy var retweetContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.isLayoutMarginsRelativeArrangement =  true
        stackView.layoutMargins = .init(top: 8, left: 12, bottom: 8, right: 12)
        
        stackView.addArrangedSubview(retweetTitleStackView)
        stackView.addArrangedSubview(retweetPostTextLabel)
        
        return stackView
    }()
    
    lazy var retweetTitleStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.alignment = .fill
        stackview.spacing = 4
        
        stackview.addArrangedSubview(retweetProfileImageView)
        stackview.addArrangedSubview(retweetNameLabel)
        stackview.addArrangedSubview(retweetUserNameLabel)
        stackview.addArrangedSubview(retweetDotLabel)
        stackview.addArrangedSubview(retweetTimeLabel)
        
        return stackview
    }()
    
    lazy var retweetProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .quaternaryLabel
        imageView.layer.cornerRadius = 12
        
        return imageView
    }()
    
    lazy var retweetNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "<Nome do autor do Post>"
        
        return label
    }()
    
    lazy var retweetUserNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.text = "<Nome do usuàrio do Post>"
        
        return label
    }()
    
    lazy var retweetDotLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.textColor = .secondaryLabel
        label.text = "."
        
        return label
    }()
    
    lazy var retweetTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.text = "<Tempo>"
        
        return label
    }()
    
    lazy var retweetPostTextLabel: UILabel = {
        let label = UILabel()
        translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "<Texto do Post>"
        
        return label
    }()
    
//-----------------------------------------------------------------//
//MARK: - Implements Action Buttons
//-----------------------------------------------------------------//
    lazy var actionsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        stackview.spacing = 0
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.layoutMargins = .init(top: 8, left: 0, bottom: 0, right: 0)
        
        stackview.addArrangedSubview(commentActionButton)
        stackview.addArrangedSubview(retweetsActionButton)
        stackview.addArrangedSubview(likeActionButton)
        stackview.addArrangedSubview(shareActionButton)
        
        return stackview
    }()
    
    lazy var commentActionButton: ActionButton = {
        let actionButton = ActionButton()
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.icon = UIImage(named: "BubbleChat")
        actionButton.count = "0"
        
        return actionButton
    }()
    
    lazy var retweetsActionButton: ActionButton = {
        let actionButton = ActionButton()
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.icon = UIImage(named: "ExchangeArrows")
        actionButton.count = "0"
        
        return actionButton
    }()
    
    lazy var likeActionButton: ActionButton = {
        let actionButton = ActionButton()
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.icon = UIImage(named: "heart")
        actionButton.count = "0"
        actionButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return actionButton
    }()
    
    @IBAction func likeButtonPressed() {
        print("Like button pressed. Like count: \(likeActionButton.count ?? "0")")
    }
    
    lazy var shareActionButton: ActionButton = {
        let actionButton = ActionButton()
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.icon = UIImage(named: "ShareArrow")
        
        return actionButton
    }()

}

//-----------------------------------------------------------------//
//MARK: - Implements ViewCode Protocol
//-----------------------------------------------------------------//
extension HomeFeedTableViewCell: ViewCode {
    
    func setUpViewHierarchy() {
        contentView.addSubview(containerStackView)
    }
    
    func applyConstraints() {
        //containerStackview constraints
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        //retweetContainerStackview constraints
        NSLayoutConstraint.activate([
            retweetContainerStackView.topAnchor.constraint(equalTo: retweetView.topAnchor),
            retweetContainerStackView.leadingAnchor.constraint(equalTo: retweetView.leadingAnchor),
            retweetContainerStackView.trailingAnchor.constraint(equalTo: retweetView.trailingAnchor),
            retweetContainerStackView.bottomAnchor.constraint(equalTo: retweetView.bottomAnchor)
        ])

        //profileImageView contraints
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 52),
            profileImageView.widthAnchor.constraint(equalToConstant: 52)
        ])
        
        //retweetProfileImageView constraints
        NSLayoutConstraint.activate([
            retweetProfileImageView.heightAnchor.constraint(equalToConstant: 24),
            retweetProfileImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func applyAdditionalSettings() {
        
    }
    
}


