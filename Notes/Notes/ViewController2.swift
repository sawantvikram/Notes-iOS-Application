//
//  ViewController2.swift
//  Notes
//
//  Created by Touchzing media on 30/08/23.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var backbtn: UILabel!
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var Heading: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))

        let tapGesturebody = UITapGestureRecognizer(target: self, action: #selector(handleTap))
             view.addGestureRecognizer(tapGesturebody)
           
           backview.addGestureRecognizer(tapGesture)
        
        body.placeholder = "Enter Your Text Here"
        // Do any additional setup after loading the view.
    }
    
    @objc private func handleTap() {
          // Dismiss the keyboard
          body.resignFirstResponder()
      }
    
    @objc func viewTapped() {
        // Your action code here

        navigationController?.popViewController(animated: true)
        
    }



    
    @IBAction func savebtntapped(_ sender: UIButton) {
        
        let currentDate = Date()
                
                // Print the current date and time
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let formattedDate = dateFormatter.string(from: currentDate)
        
        
        
        let dbManager = DatabaseHelper.getInstance()
        
        var heading = Heading.text
        var body  = body.text
        var date = formattedDate
        
        if(heading != nil && body !=  nil){
            dbManager.insertNoteItem(heading: heading!, body: body!, date: date)
           
        }
        
        
        navigationController?.popViewController(animated: true)
        
    }
    
 

    

}
extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height

            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = !self.text.isEmpty
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
    /// Clears the placeholder label and changes the text color when the user begins editing
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = true
        }
        
        self.textColor = UIColor.black
    }
    
    /// Shows the placeholder label again and changes the text color back to gray when the user finishes editing
    public func textViewDidEndEditing(_ textView: UITextView) {
        if self.text.isEmpty {
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderLabel.isHidden = false
            }
            
            self.textColor = UIColor.lightGray
        }
    }
    
    /// Dismiss the keyboard when tapping outside the text view
//    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//
//        let touch = touches.first
//
//        if touch?.view == self && self.text.isEmpty {
//            self.endEditing(true)
//        }
//    }

}
