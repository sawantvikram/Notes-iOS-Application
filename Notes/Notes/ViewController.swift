//
//  ViewController.swift
//  Notes
//
//  Created by Touchzing media on 29/08/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CollectionViewWaterfallLayoutDelegate  {
    
    
    var selectedIndexPath : IndexPath?
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var cellHeight = 100
        
        
        if(indexPath.row == 0){
            let cell = collectionbox.dequeueReusableCell(withReuseIdentifier: "ConstantCell", for: indexPath as IndexPath)
            
            cellHeight = 180
            
            
        }
        else{
            
            var note = notes[indexPath.row]
            let cell = collectionbox.dequeueReusableCell(withReuseIdentifier: "ChangingCell", for: indexPath as IndexPath) as! ChangingCell
            //            cellHeight = cell.frame.size.height
            
            
            
            
            let dbManager = DatabaseHelper.getInstance()
            notes = dbManager.getAllNotesItems()
            
            note = notes[indexPath.row]
            
            
            
            cell.body.text = note["Body"]
            cell.heading.text = note["Heading"]
            cell.date.text = note["Date"]
            
            var hedhei = (cell.heading.frame.size.height) + 5
            var datehei = (cell.heading.frame.size.height) + 5
            var numeroflines = ( countCharacters(in: cell.body.text! )     / 20)
            var bodyhei = numeroflines * 22
            if(numeroflines > 6){
                
                bodyhei = 120
            }else if(numeroflines == 1 || numeroflines == 0){
                bodyhei = 35
            }
            
            cellHeight = Int(hedhei +   CGFloat(bodyhei) + datehei)
            
        }
        
        
        
        
        
        //        cellHeight = 100.0
        
//        return CGFloat(cellHeight)
        return CGSize(width: 140, height: cellHeight)
    }
    
    
    
    
    public var customCollectionViewLayout: CollectionViewWaterfallLayout? {
        get {
            return self.collectionbox?.collectionViewLayout as? CollectionViewWaterfallLayout
        }
        set {
            if newValue != nil {
                self.collectionbox?.collectionViewLayout = newValue!
            }
        }
    }
    
    
    
    
    @IBOutlet weak var collectionbox: UICollectionView!
    @IBOutlet weak var profpic: UIImageView!
    var notes : [[String:String]] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profpic.image = UIImage(named: "profpic")
        profpic.layer.cornerRadius = profpic.frame.height / 2
        
        let dbManager = DatabaseHelper.getInstance()
        notes = dbManager.getAllNotesItems()
        
        self.customCollectionViewLayout = CollectionViewWaterfallLayout()
        
        
//        self.customCollectionViewLayout?.delegate = self
//        self.customCollectionViewLayout?.numberOfColumns = 2
        
//        self.customCollectionViewLayout?.invalidateLayout()
        collectionbox?.collectionViewLayout.invalidateLayout()
        self.collectionbox.reloadData()
        collectionbox?.collectionViewLayout.invalidateLayout()
//        customCollectionViewLayout?.invalidateLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        collectionbox?.collectionViewLayout.invalidateLayout()
        customCollectionViewLayout?.invalidateLayout()
        
        // Update your notes array with the latest data from the database
        let dbManager = DatabaseHelper.getInstance()
        notes = dbManager.getAllNotesItems()
        print(notes.count)
        print(notes.count)
       
            self.notes = dbManager.getAllNotesItems()
//        customCollectionViewLayout?.invalidateLayout()

        collectionbox?.collectionViewLayout.invalidateLayout()
        customCollectionViewLayout?.invalidateLayout()
        
            self.collectionbox.reloadData()
        collectionbox?.collectionViewLayout.invalidateLayout()
        
//        }

        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        var cellHeight = 100
        
        
        if(indexPath.row == 0){
            let cell = collectionbox.dequeueReusableCell(withReuseIdentifier: "ConstantCell", for: indexPath)
            
            cellHeight = 180
            
            
        }
        else{
            
            var note = notes[indexPath.row]
            let cell = collectionbox.dequeueReusableCell(withReuseIdentifier: "ChangingCell", for: indexPath) as! ChangingCell
            //            cellHeight = cell.frame.size.height
            
            
            
            
            let dbManager = DatabaseHelper.getInstance()
            notes = dbManager.getAllNotesItems()
            
            note = notes[indexPath.row]
            
            
            
            cell.body.text = note["Body"]
            cell.heading.text = note["Heading"]
            cell.date.text = note["Date"]
            
            var hedhei = (cell.heading.frame.size.height) + 5
            var datehei = (cell.heading.frame.size.height) + 5
            var numeroflines = ( countCharacters(in: cell.body.text! )     / 20)
            var bodyhei = numeroflines * 25
            if(numeroflines > 6){
                
                bodyhei = 120
            }else if(numeroflines == 1){
                bodyhei = 50
            }
            
            cellHeight = Int(hedhei +   CGFloat(bodyhei) + datehei)
            
        }
        
        
        
        
        
        //        cellHeight = 100.0
        
        return CGFloat(cellHeight)
    }
    
    
    func countCharacters(in string: String) -> Int {
        return string.count
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        
        if(indexPath.row == 0){
            
            performSegue(withIdentifier: "tocontroller2", sender: nil)
        }else{
            performSegue(withIdentifier: "tocontroller2a", sender: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dbManager = DatabaseHelper.getInstance()
        notes = dbManager.getAllNotesItems()
        print(notes.count)
        print(notes.count)
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("position number : \(indexPath.row)")
        
        if(indexPath.row == 0){
            let cell = collectionbox.dequeueReusableCell(withReuseIdentifier: "ConstantCell", for: indexPath)
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor(red: 0.727, green: 0.901, blue: 0.994, alpha: 1).cgColor
            cell.layer.cornerRadius = 8
            cell.isUserInteractionEnabled = true
            cell.layer.backgroundColor = UIColor(red: 0.96, green: 0.984, blue: 1, alpha: 1).cgColor
            return cell
            
        }        else{
            
            let dbManager = DatabaseHelper.getInstance()
            notes = dbManager.getAllNotesItems()
            
            let note = notes[indexPath.row]
            
            print(notes)
            let cell = collectionbox.dequeueReusableCell(withReuseIdentifier: "ChangingCell", for: indexPath) as! ChangingCell
            
            cell.heading.text = note["Heading"]
            cell.body.text = note["Body"]
            cell.isUserInteractionEnabled = true
            
            cell.date.text = note["Date"]
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            cell.layer.borderColor = UIColor(red: 0.894, green: 0.905, blue: 0.925, alpha: 1).cgColor
            cell.layer.backgroundColor = UIColor(red: 0.988, green: 0.99, blue: 0.992, alpha: 1).cgColor
            
            
            
            return cell
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tocontroller2a" {

            let note = notes[selectedIndexPath!.row]
            
            if let destinationVC = segue.destination as? ViewController2a {
                // Assuming you have a property named "dataToPass" in ViewController2
                destinationVC.heading = note["Heading"]
                destinationVC.body = note["Body"]
               
            }
        }
        
       
    }
    
    
    
}

