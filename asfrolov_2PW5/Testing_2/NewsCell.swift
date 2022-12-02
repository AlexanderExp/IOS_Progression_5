//
//  NewsCell.swift
//  Testing_2
//
//  Created by admin on 30.11.2022.
//

import Foundation
import UIKit

final class NewsCell: UITableViewCell {
    static let reuseIdentifier = "NewsCell"
    private var newsImageView = UIImageView()
    private var newsTitleLabel = UILabel()
    private var newsDescriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    private func setupView() {
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    public func configure(_ news: NewsViewModel) {
        newsTitleLabel.text = news.title
        newsDescriptionLabel.text = news.description
        //newsImageView.imageFrom(url: news.imageURL!)
        if let data = news.imageData {
            newsImageView.image = UIImage(data:data)
        } else {
            if let url = news.imageURL {
                URLSession.shared.dataTask(with: url) {[weak self] data,_,error in
                    guard let data = data, error == nil else {
                        return
                    }
                    news.imageData = data
                    DispatchQueue.main.async {
                        self?.newsImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
    }
    
    /*override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView = UIImageView()
        newsTitleLabel = UILabel()
        newsDescriptionLabel = UILabel()
    }*/
    
    private func setupImageView() {
        newsImageView.image = UIImage(named: "landscape")
        newsImageView.layer.cornerRadius = 8
        newsImageView.layer.cornerCurve = .continuous
        newsImageView.clipsToBounds = true
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(newsImageView)
        newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        newsImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        newsImageView.pinWidth(to: newsImageView.heightAnchor)
    }
    private func setupTitleLabel() {
        newsTitleLabel.text = "Hello"
        newsTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        newsTitleLabel.textColor = .label
        newsTitleLabel.numberOfLines = 1
        
        contentView.addSubview(newsTitleLabel)
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        newsTitleLabel.heightAnchor.constraint(equalToConstant: newsTitleLabel.font.lineHeight).isActive = true
        
        newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 12).isActive = true
        
        newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        
        newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
    }
    private func setupDescriptionLabel() {
        newsDescriptionLabel.text = "World"
        newsDescriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        newsDescriptionLabel.textColor = .secondaryLabel
        newsDescriptionLabel.numberOfLines = 0
        
        contentView.addSubview(newsDescriptionLabel)
        newsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        newsDescriptionLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 12).isActive = true
        
        newsDescriptionLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 12).isActive = true
        
        newsDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        newsDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12).isActive = true
    }
    
}
