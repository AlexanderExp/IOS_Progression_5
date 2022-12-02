//
//  ViewController.swift
//  Testing_2
//
//  Created by admin on 10.10.2022.
//

import UIKit


extension CALayer {
    func applyShadow() {
        self.shadowColor = UIColor(red: 0.5, green: 0.5, blue: 1, alpha: 0.5).cgColor
        self.shadowOffset = CGSize(width: 0, height: 3)
        self.shadowOpacity = 1.0
        self.shadowRadius = 10.0
        self.masksToBounds = false
    }
}

final class WelcomeViewController: UIViewController {
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    
    let commentView = UIView()
    
    let colorPaletteView = ColorPaletteView()
    
    let notesView = NotesViewController()
    
    let newsView = NewsListViewController()
    
    private let incrementButton = UIButton()
    
    
    private var value: Int = 0
    var buttonsSV = UIStackView()
    
    
    private func setupIncrementButton() {
        incrementButton.isEnabled = true
        incrementButton.setTitle("Press me", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize:
                                                        16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.layer.applyShadow()
        self.view.addSubview(incrementButton)
        
        incrementButton.setHeight(48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        
        incrementButton.addTarget(self, action:
#selector(incrementButtonPressed), for: .touchUpInside)
    }

    @objc
    private func incrementButtonPressed() {
        value += 1
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        UIView.transition(with: commentLabel, duration: 2, options: .transitionCrossDissolve, animations: {[self] in updateCommentLabel(value: self.value)}, completion: nil)
        UIView.transition(with: valueLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {[self] in valueLabel.text = "\(self.value)"}, completion: nil)
    }
    
    private func updateUI() -> Void {
        valueLabel.text = "\(value)"
        updateCommentLabel(value: value)
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        
        incrementButton.addSubview(valueLabel)
        valueLabel.isEnabled = true
        
        valueLabel.pinCenterX(to: incrementButton)
        valueLabel.pinHeight(to: incrementButton, -64)
        
    }
    
    public func setupView() {
        view.backgroundColor = .systemGray6
        colorPaletteView.isHidden = true
        
        setupValueLabel()
        setupIncrementButton()
        setupCommentView()
        setupMenuButtons()
        setupColorControlSV()
    }
    
    private func setupCommentView() {
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        
        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        
        commentLabel.font = .systemFont(ofSize: 14, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        
        commentLabel.text = "Toniiight, i'm gonna give it all tooo youuu"
        commentLabel.textColor = .black
        commentLabel.font = .systemFont(ofSize: 16)
        
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top: 16, .left: 16,
                                           .bottom: 16, .right: 16])
    }
    
    func updateCommentLabel(value: Int) {
            switch value {
            case 0...10:
                commentLabel.text = "1"
            case 10...20:
                commentLabel.text = "2"
            case 20...30:
                commentLabel.text = "3"
            case 30...40:
                commentLabel.text = "4"
            case 40...50:
                commentLabel.text = "! ! ! ! ! ! ! ! ! "
            case 50...60:
                commentLabel.text = "big boy"
            case 60...70:
                commentLabel.text = "70 70 70 moreeeee"
            case 70...80:
                commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ "
            case 80...90:
                commentLabel.text = "80+\n go higher!"
            case 90...100:
                commentLabel.text = "100!! to the moon!!"
            default:
                break
        }
    }
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0,
                                              weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo:
                                        button.widthAnchor).isActive = true
        return button
    }
    
    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    @objc
    private func changeColor(_ slider: ColorPaletteView) {
        
        UIView.animate(withDuration: 0.5) {[self] in
            self.view.backgroundColor = slider.chosenColor
        }
    }
    
    @objc
    private func notesButtonPressed() {
        present(notesView, animated: true, completion: nil)
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    public func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
     
        let notesButton = makeMenuButton(title: "🗒")
        notesButton.addTarget(self, action: #selector(notesButtonPressed), for: .touchUpInside)
                                         
        let newsButton = makeMenuButton(title: "📰")
        newsButton.addTarget(self, action: #selector(newsButtonPressed), for: .touchUpInside)
     
        let buttonsSV = UIStackView(arrangedSubviews:
                                    [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        self.view.addSubview(buttonsSV)
                
        buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinButton(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
    }
    
    @objc
    private func newsButtonPressed(){
        // present(newsView, animated: true)
        navigationController?.pushViewController(newsView, animated: true)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    private func setupColorControlSV() {
        colorPaletteView.isHidden = true
        colorPaletteView.addTarget(self, action: #selector(changeColor), for: .touchDragInside)
        view.addSubview(colorPaletteView)
        
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorPaletteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 8),
            colorPaletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            colorPaletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            colorPaletteView.bottomAnchor.constraint(equalTo: incrementButton.topAnchor, constant: 300)
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}
