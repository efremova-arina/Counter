//
//  ViewController.swift
//  Counter
//
//  Created by Арина Ефремова on 31.03.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterValue: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButtom: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var history: UITextView!
    
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
        // Do any additional setup after loading the view.
        plusButton.tintColor = .red
        minusButtom.tintColor = .blue
        resetButton.tintColor = .black
        history.isEditable = false
        history.isSelectable = true
        history.text = "История изменений: \n"
        history.layer.cornerRadius = 15
        history.layer.masksToBounds = true
        counterValue.layer.cornerRadius = 15
        counterValue.layer.masksToBounds = true
    }
    
    private func updateCounterLabel() {
        counterValue.text = "Значение счетчика: \(count)"
    }
    
    private func scrolling() {
        let range = NSRange(location: history.text.count - 1, length: 1)
        history.scrollRangeToVisible(range)
    }
        
    private func logEvent(_ message: String) {
        let dateString = dateFormatter.string(from: Date())
        history.text += "[\(dateString)] : \(message)\n"
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

