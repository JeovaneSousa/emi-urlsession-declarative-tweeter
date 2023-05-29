//
//  HomeFeedViewController.swift
//  LearningTask-12.3
//
//  Created by rafael.rollo on 05/12/2022.
//

import UIKit

class HomeFeedViewController: UIViewController {
    
    var homeViewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel?.delegate = self
        applyHomeTheme()
        setUpViewCode()
        homeViewModel?.carregaFeed()
    }
    
//-----------------------------------------------------------------//
//MARK: - Implements HomeFeedUI
//-----------------------------------------------------------------//
    
    lazy var tablevView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeFeedTableViewCell.self, forCellReuseIdentifier: HomeFeedTableViewCell.identifier)
        
        return tableView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.image = UIImage(systemName: "plus")
        button.configuration?.baseForegroundColor = .white
        button.configuration?.baseBackgroundColor = .cornflowerBlue
        button.configuration?.cornerStyle = .capsule
        button.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .large)
        button.addTarget(self, action: #selector(addTweetButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    @IBAction func addTweetButtonPressed(){
        let controller = PostViewController()
        controller.postViewModel = PostViewModel()
        controller.postViewModel?.tweetApi = TweetAPI()
        controller.postViewModel?.delegate = self
        
        controller.modalPresentationStyle = .fullScreen
        self.showDetailViewController(controller, sender: self)
    }
}

//-----------------------------------------------------------------//
//MARK: - Implements TableView DataSource
//-----------------------------------------------------------------//
extension HomeFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeFeedTableViewCell.identifier, for: indexPath) as? HomeFeedTableViewCell else {
            fatalError("Unable to acquire cell with identifier \(HomeFeedTableViewCell.identifier)")
        }
        
        let post = homeViewModel?.posts[indexPath.row]
        cell.post = post
        
        return cell
    }
    
}

//-----------------------------------------------------------------//
//MARK: - Implements TableView Delegate
//-----------------------------------------------------------------//
extension HomeFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


//-----------------------------------------------------------------//
//MARK: - Implements Delegates
//-----------------------------------------------------------------//
extension HomeFeedViewController: HomeFeedViewControllerDelegate {
    func HomeFeedViewControllerDelegate(viewModel: HomeViewModel, didLoadFeedPosts posts: [FeedPost]) {
        tablevView.reloadData()
    }
    
    func HomeFeedViewControllerDelegate(viewModel: HomeViewModel, errorOccurred error: TweetApiError) {
        notifyAboutError(error.errorMessage)
    }
    
}

extension HomeFeedViewController: PostViewModelDelegate {
    
    func PostViewModelDelegate(in viewModel: PostViewModel, didPostTuit feedPost: FeedPost) {
        homeViewModel?.carregaFeed()
    }
    
    func PostViewModelDelegate(in viewModel: PostViewModel, foundError error: TweetApiError) {
        notifyAboutError(error.errorMessage)
    }
    
}

//-----------------------------------------------------------------//
//MARK: - Implements VieiwCode Protocol
//-----------------------------------------------------------------//
extension HomeFeedViewController: ViewCode {
    func setUpViewHierarchy() {
        view.addSubview(tablevView)
        view.addSubview(addButton)
    }
    
    func applyConstraints() {
        
        //tableView constraints
        NSLayoutConstraint.activate([
            tablevView.topAnchor.constraint(equalTo: view.topAnchor),
            tablevView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tablevView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tablevView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        //addButton constraints
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 56),
            addButton.widthAnchor.constraint(equalToConstant: 56),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func applyAdditionalSettings() {
        
    }
    
    
}
