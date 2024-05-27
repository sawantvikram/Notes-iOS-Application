//
//  ViewController2a.swift
//  Notes
//
//  Created by Touchzing media on 04/09/23.
//

import UIKit

class ViewController2a: UIViewController {
    var heading : String?
    var body : String?
    
    
    @IBOutlet weak var backview: UIView!
    
    @IBOutlet weak var Heading: UILabel!
    
    @IBOutlet weak var Body: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Heading.text = heading
        
        Body.text = body
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        backview.addGestureRecognizer(tapGesture)
        
        
        
    }
    
    @objc func viewTapped() {
        // Your action code here

        navigationController?.popViewController(animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
