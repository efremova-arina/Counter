//
//  ViewController.swift
//  Counter
//
//  Created by Арина Ефремова on 31.03.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var historyTextView: UITextView!
    
    private var count = 0 {
        didSet {
            count = max(count, 0)
            updateCounterLabel()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        plusButton.tintColor = .red
        minusButton.tintColor = .blue
        resetButton.tintColor = .black
        historyTextView.isEditable = false
        historyTextView.isSelectable = true
        historyTextView.text = "История изменений: \n"
        historyTextView.layer.cornerRadius = 15
        historyTextView.layer.masksToBounds = true
        counterLabel.layer.cornerRadius = 15
        counterLabel.layer.masksToBounds = true
    }
    
    private func updateCounterLabel() {
        counterLabel.text = "Значение счетчика: \(count)"
    }
    
    private func scrolling() {
        let range = NSRange(location: historyTextView.text.count - 1, length: 1)
        historyTextView.scrollRangeToVisible(range)
    }
        
    private func logEvent(_ message: String) {
        let dateString = dateFormatter.string(from: Date())
        historyTextView.text += "[\(dateString)] : \(message)\n"
        scrolling()
    }

    @IBAction func increaseValue(_ sender: Any) {
        count += 1
        logEvent("значение изменено на +1")
    }
    
    @IBAction func decreaseValue(_ sender: Any) {
        if count > 0 {
            count -= 1
            logEvent("значение изменено на -1")
        } else {
            logEvent("попытка уменьшить значение счетчика ниже 0")
        }
    }
    
    @IBAction func resetValue(_ sender: Any) {
        count = 0
        logEvent("Значение счетчика сброшено")
    }
}

