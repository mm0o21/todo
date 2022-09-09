//
//  EditViewController.swift
//  todo
//
//  Created by Maoko Furuya on 2022/09/05.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var todoField: UITextField!
    @IBOutlet var yarukoto: UITextView!
    @IBOutlet var date: UITextField!
    var datePicker = UIDatePicker()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textviewの見た目
        yarukoto.layer.borderWidth = 0.7
        yarukoto.layer.borderColor = UIColor(hex: "dcdcdc",alpha: 1.0).cgColor
        yarukoto.layer.cornerRadius = 10.0
        
        //日付のやつ関連
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        date.inputView = datePicker
        date.inputAccessoryView = toolbar
        
        todoField.delegate = self
    }
    
    //日付のdoneボタン
    @objc func done() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月d日"
        date.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    @IBAction func save(_ sender: Any){
        let realm = try! Realm()
        let todo = Todo()
        todo.title = todoField.text!
        
        try! realm.write{
            realm.add(todo)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.todoField.resignFirstResponder()
        return true
    }

}
