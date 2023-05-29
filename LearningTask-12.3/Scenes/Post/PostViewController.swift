//
//  PostViewController.swift
//  LearningTask-12.3
//
//  Created by Jeovane Barbosa on 30/01/23.
//

import UIKit

class PostViewController: UIViewController {

    var postViewModel: PostViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViewCode()
    }
    
//-----------------------------------------------------------------//
//MARK: - Implements PostViewUI
//-----------------------------------------------------------------//
    lazy var titleView: UIView = {
        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(headerStackView)
        
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .quaternaryLabel

        
        titleView.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            separatorView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor)
        ])
        
        return titleView
    }()
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.tintColor = .brown
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 20, bottom: 16, right: 20)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(tuitButton)
        return stackView
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.attributedTitle = AttributedString("Cancel",attributes: AttributeContainer([
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black]
        ))
        button.configuration?.contentInsets = .init(top: 6, leading: 0, bottom: 6, trailing: 0)
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    @IBAction func cancelButtonPressed(){
        self.dismiss(animated: true)
    }
    
    lazy var tuitButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.attributedTitle = AttributedString("Tuit", attributes: AttributeContainer([
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .foregroundColor: UIColor.white,
        ]))
        button.configuration?.cornerStyle = .capsule
        button.configuration?.baseBackgroundColor = .cornflowerBlue
        button.configuration?.contentInsets = .init(top: 6, leading: 24, bottom: 6, trailing: 24)
        button.isHighlighted = true
        button.isUserInteractionEnabled = false
        button.isEnabled = true
        button.addTarget(self, action: #selector(criaPost), for: .touchUpInside)
       
        return button
    }()
    
    @IBAction func criaPost() {
        let tuit = FeedPostInput(textContent: tweetTextView.text)
        postViewModel?.postTuit(comTuit: tuit)
        
        self.dismiss(animated: true)
    }
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = . horizontal
        stackView.spacing = 12
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16, left: 20, bottom: 16, right: 20)
        stackView.distribution = .fill
        stackView.alignment = .firstBaseline
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(textStackView)
        
        return stackView
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .quaternaryLabel
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 28),
            imageView.widthAnchor.constraint(equalToConstant: 28)
        ])

        return imageView
    }()
    
    lazy var textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(accessControlButton)
        stackView.addArrangedSubview(tweetTextView)
        
        return stackView
    }()
    
    lazy var accessControlButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.configuration?.attributedTitle = AttributedString("Public", attributes: AttributeContainer([
            .font: UIFont.systemFont(ofSize: 12)
        ]))
        button.configuration?.baseForegroundColor = .cornflowerBlue
        button.configuration?.baseBackgroundColor = .cornflowerBlue
        button.configuration?.cornerStyle = .capsule
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    lazy var tweetTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .tertiaryLabel
        textView.text = "What`s happening?"
        
        return textView
    }()
    
    lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .quaternaryLabel
        
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        return separatorView
    }()
    
    lazy var footerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16, left: 20, bottom: 24, right: 20)
        
        stackView.addArrangedSubview(imageButton)
        stackView.addArrangedSubview(charCounterButton)
        return stackView
    }()
    
    lazy var imageButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.image = UIImage(systemName: "photo")
        button.configuration?.contentInsets = .init(top: 6, leading: 0, bottom: 6, trailing: 0)
        
        return button
    }()
    
    lazy var charCounterButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseForegroundColor = .cornflowerBlue
        button.configuration?.baseBackgroundColor = .tertiaryLabel
        button.configuration?.cornerStyle = .capsule
        button.isUserInteractionEnabled = false
        button.configuration?.attributedTitle = AttributedString("280", attributes: AttributeContainer([
            .font: UIFont.systemFont(ofSize: 12, weight: .bold)
        ]))
        
        return button
    }()
}

//-----------------------------------------------------------------//
//MARK: - Implements TextView Delegate
//-----------------------------------------------------------------//
extension PostViewController: UITextViewDelegate {
    var placeHolder: String {return "What`s happening?"}
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let text = textView.text, text == placeHolder {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let text = textView.text, text.isEmpty {
            textView.text = placeHolder
            textView.textColor = .tertiaryLabel
        }
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        updateTuitButton(for: textView)
        updateCharCounter(for: textView)
    }
    
    private func updateCharCounter(for textView: UITextView) {
        let maxCharCount = 280
        if textView.text == placeHolder {
            charCounterButton.titleLabel?.text = 280.description
        }
        
        let counter:Int = (maxCharCount - textView.text.count)

        switch counter {
            
        case 0: charCounterButton.configuration?.baseForegroundColor = .cornflowerBlue
            
        case 1...280: charCounterButton.configuration?.baseForegroundColor = .cornflowerBlue
            
        case ..<0: charCounterButton.configuration?.baseForegroundColor = .cinnabar
            
        default: print()
        }
        
        charCounterButton.titleLabel?.text = abs(counter).description
        
    }
    
    private func updateTuitButton(for textView: UITextView) {
        switch textView.text.count {
            
        case 0: blockTuit()
            
        case 1...280: if textView.text != placeHolder { allowTuit() }

        case 281...: blockTuit()
        
        default: return
        }

    }
    
    private func allowTuit() {
        tuitButton.isUserInteractionEnabled = true
        tuitButton.isHighlighted = false
    }
    
    private func blockTuit() {
        tuitButton.isUserInteractionEnabled = false
        tuitButton.isHighlighted = true
    }
}

//-----------------------------------------------------------------//
//MARK: - Implements ViewCode Protocol
//-----------------------------------------------------------------//
extension PostViewController: ViewCode {
    func setUpViewHierarchy() {
        view.addSubview(titleView)
        view.addSubview(containerStackView)
        view.addSubview(separatorView)
        view.addSubview(footerStackView)
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: titleView.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            headerStackView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            footerStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func applyAdditionalSettings() {
        let authenticatedUser = UserAuthentication().get()!.user
        profileImageView.setImageByDowloading(url: authenticatedUser.profilePictureURL)
    }
    
    
}

