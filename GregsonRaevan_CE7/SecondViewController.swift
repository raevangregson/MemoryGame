//
//  SecondViewController.swift
//  GregsonRaevan_CE7
//
//  Created by Raevan Gregson on 2/22/17.
//  Copyright © 2017 Raevan Gregson. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {
    
    @IBOutlet weak var congratsLabel: UILabel!
    @IBOutlet weak var highscoreList: UITextView!
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var txtView: UITextView!
    
    var timeLabel = ""
    var scores = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //set up my UI for my view controller
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        self.view.insertSubview(backgroundImage, at: 0)
        highscoreList.text = ""
        highScore.layer.cornerRadius = 15
        highScore.layer.masksToBounds = true
        txtView.layer.cornerRadius = 15
        txtView.layer.masksToBounds = true
        play.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
        
        congratsLabel.text = "You Completed the Puzzle in \(timeLabel)'s"
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //load in info
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Score")

        do {
            let results =
                try managedContext.fetch(fetchRequest)
            scores = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "time", ascending: true)
        var sortedResults: NSArray = scores as NSArray
        sortedResults = sortedResults.sortedArray(using: [descriptor]) as NSArray
        //set my headers as string vars so I can add padding to them to space them and help with formatting
        let initi = "Initials:"
        let mo = "Moves:"
        let da = "Date:"
        let ti = "Time:"
        //first I append the headers to the txt field
        highscoreList.text.append(initi.padding(toLength: 15, withPad: " ", startingAt: 0)+(mo.padding(toLength: 15, withPad: " ", startingAt: 0)+da.padding(toLength: 15, withPad: " ", startingAt: 0)+ti.padding(toLength: 15, withPad: " ", startingAt: 0)))
        
        //Then I loop through the array of managed objects and append the information in to the textfield using paddign to space them/
        for score in sortedResults
        {
            let initials = String(describing: (score as AnyObject).value(forKey: "initial")!)
            let moves = String(describing:(score as AnyObject).value(forKey: "move")!)
            let date = String(describing: (score as AnyObject).value(forKey: "date")!)
            let time = String(describing: (score as AnyObject).value(forKey: "time")!)
            highscoreList.text.append("\n \(initials.padding(toLength: 15, withPad: " ", startingAt: 0)) \(moves.padding(toLength: 15, withPad: " ", startingAt: 0))\(date.padding(toLength: 15, withPad: " ", startingAt: 0)) \(time)")
        }
    }
    
   
    @IBAction func playAgain(_ sender: UIButton) {
        //dismiss back to the other view controller
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
