//
//  AddNoteCell.swift
//  Testing_2
//
//  Created by admin on 21.11.2022.
//

import Foundation
import UIKit

final class AddNoteCell: UITableViewCell {
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    public var addButton = UIButton()
    weak var delegate: AddNoteDelegate?
    
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        textView.delegate = self
        textView.text = "Type smth"
        textView.textColor = .lightGray
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        // textView.textColor = .black
        textView.backgroundColor = .clear
        textView.setHeight(140)
        textView.isHidden = false

    
        
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(44)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addButton.isEnabled = true
        addButton.alpha = 0.5
        addButton.isHidden = false
        
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = .systemGray5
    }
    
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        
        let note = ShortNote(text: textView.text)
        if (note.text != "") {
            delegate?.newNoteAdded(note)
            
        }
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

protocol AddNoteDelegate:NSObjectProtocol {
    func newNoteAdded(_: ShortNote)
}

extension AddNoteCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type smth"
            textView.textColor = UIColor.lightGray
        }
    }
}
