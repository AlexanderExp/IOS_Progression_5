//
//  NewsViewController.swift
//  Testing_2
//
//  Created by admin on 30.11.2022.
//

import Foundation
import UIKit

final class NewsViewController: UIViewController {
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    
    public func setValues(nvm: NewsViewModel) {
        titleLabel.text = nvm.title
        descriptionLabel.text = nvm.description

        if let data = nvm.imageData {
            imageView.image = UIImage(data:data)
        } else {
        if let url = nvm.imageURL {
            URLSession.shared.dataTask(with: url) {[weak self] data,_,error in
                    guard let data = data, error == nil else {
                        return
                    }
                    nvm.imageData = data
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavbar()
        setImageView()
        setTitleLabel()
        setDescriptionLabel()
    }
    private func setupNavbar() {
        navigationItem.title = "You are lovely !"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "chevron.left"),
        style: .plain,
        target: self,
        action: #selector(goBack)
        )
        navigationItem.leftBarButtonItem?.tintColor = .label
    }
    
    private func setImageView() {
        //imageView.image = UIImage(named: "landscape")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.pin(to: view, [.left: 0, .right: 0])
        imageView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        imageView.pinHeight(to: imageView.widthAnchor, 1)
    }
    
    private func setTitleLabel() {
        //titleLabel.text = "Hello"
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .label
        
        view.addSubview(titleLabel)
        
        titleLabel.pinTop(to: imageView.bottomAnchor, 12)
        titleLabel.pin(to: view, [.left: 16, .right: 16])
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16).isActive = true
    }
    
    private func setDescriptionLabel() {
        //descriptionLabel.text = "World"
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .secondaryLabel
        
        view.addSubview(descriptionLabel)
        
        descriptionLabel.pin(to: view, [.left: 16, .right: 16])
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 8)
    }
    
    @objc
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
