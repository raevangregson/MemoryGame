//
//  ViewController.swift
//  GregsonRaevan_CE7
//
//  Created by Raevan Gregson on 2/22/17.
//  Copyright © 2017 Raevan Gregson. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    //this is where I set my UI to Outlets
    @IBOutlet var iphoneContainers: [UIView]!
    @IBOutlet var ipadContainers: [UIView]!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var ipadImage: [UIImageView]!
    @IBOutlet var iphoneImage: [UIImageView]!
    @IBOutlet var labelView: [UIView]!
    
    //I use an array to track matches two holders to track my two selection tags in the ui a timer object for my main timer and two seperate arrays to hold my cards for iphone and ipad along with a counter so I know when all matches have been found.
    var matches = [UIImageView]()
    var holder1 = 0
    var holder2 = 0
    var timer:Timer?
    var counter = 0
    var iphoneMatches = [Int:UIImage]()
    var ipadMatches = [Int:UIImage]()
    var matchCount = 0
    var moves = 0
    var initials = ""
    var scores = [NSManagedObject]()
    var time = ""
    var taps = 0
    
    private var managedContext:NSManagedObjectContext!
    private var entityDescription:NSEntityDescription!
    private var newScore:NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //setup the core data
        managedContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        entityDescription = NSEntityDescription.entity(forEntityName: "Score", in: managedContext)
        newScore = NSManagedObject(entity: entityDescription, insertInto: managedContext)
        setup()
    }
    
    //I do my setup in its own function and call it in the view did load so I can recall it and resetup when the user wants to play again
    func setup()
    {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        self.view.insertSubview(backgroundImage, at: 0)
        labels[0].text = ""
        labels[1].text = ""
        for (view,views) in zip(iphoneImage,ipadImage){
            view.backgroundColor = UIColor.white
            views.backgroundColor = UIColor.white
        }
        for view in ipadContainers
        {
            view.layer.cornerRadius = 15
            view.layer.masksToBounds = true
        }
        for (view,views) in zip(buttons,labelView)
        {
            view.layer.cornerRadius = 15
            view.backgroundColor = UIColor.white
            views.layer.cornerRadius = 15
        }
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            ipadSetup()
        }
        else if UIDevice.current.userInterfaceIdiom == .phone
        {
            iphoneSetup()
        }
    }
    @IBAction func buttonPress(_ sender: UIButton) {
        switch sender.tag{
            //diffrentiate between the two buttons with a switch
        case 0:
            //Once start game is hit I flash the cards and then set there image to the back image after 5 seconds using a timer this is where I loop through as stated above and match the corresponding view with its tag - both in iphone and ipad
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(ViewController.count), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
            buttons[0].isEnabled = false
            buttons[0].setTitle("Match All the Tiles!", for: .disabled)
            buttons[0].titleLabel?.numberOfLines = 1
            buttons[0].titleLabel?.adjustsFontSizeToFitWidth = true
            
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ipadFlash), userInfo: nil, repeats: false)
                
                for views in ipadImage{
                    switch views.tag{
                    case 0:
                        views.image = ipadMatches[0]
                    case 1:
                        views.image = ipadMatches[1]
                    case 2:
                        views.image = ipadMatches[2]
                    case 3:
                        views.image = ipadMatches[3]
                    case 4:
                        views.image = ipadMatches[4]
                    case 5:
                        views.image = ipadMatches[5]
                    case 6:
                        views.image = ipadMatches[6]
                    case 7:
                        views.image = ipadMatches[7]
                    case 8:
                        views.image = ipadMatches[8]
                    case 9:
                        views.image = ipadMatches[9]
                    case 10:
                        views.image = ipadMatches[10]
                    case 11:
                        views.image = ipadMatches[11]
                    case 12:
                        views.image = ipadMatches[12]
                    case 13:
                        views.image = ipadMatches[13]
                    case 14:
                        views.image = ipadMatches[14]
                    case 15:
                        views.image = ipadMatches[15]
                    case 16:
                        views.image = ipadMatches[16]
                    case 17:
                        views.image = ipadMatches[17]
                    case 18:
                        views.image = ipadMatches[18]
                    case 19:
                        views.image = ipadMatches[19]
                    case 20:
                        views.image = ipadMatches[20]
                    case 21:
                        views.image = ipadMatches[21]
                    case 22:
                        views.image = ipadMatches[22]
                    case 23:
                        views.image = ipadMatches[23]
                    case 24:
                        views.image = ipadMatches[24]
                    case 25:
                        views.image = ipadMatches[25]
                    case 26:
                        views.image = ipadMatches[26]
                    case 27:
                        views.image = ipadMatches[27]
                    case 28:
                        views.image = ipadMatches[28]
                    case 29:
                        views.image = ipadMatches[29]
                    default:
                        break
                    }
                }
            }
            else if UIDevice.current.userInterfaceIdiom == .phone
            {
                _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(iphoneFlash), userInfo: nil, repeats: false)
                
                for view in iphoneImage{
                    switch view.tag{
                    case 0:
                        view.image = iphoneMatches[0]
                    case 1:
                        view.image = iphoneMatches[1]
                    case 2:
                        view.image = iphoneMatches[2]
                    case 3:
                        view.image = iphoneMatches[3]
                    case 4:
                        view.image = iphoneMatches[4]
                    case 5:
                        view.image = iphoneMatches[5]
                    case 6:
                        view.image = iphoneMatches[6]
                    case 7:
                        view.image = iphoneMatches[7]
                    case 8:
                        view.image = iphoneMatches[8]
                    case 9:
                        view.image = iphoneMatches[9]
                    case 10:
                        view.image = iphoneMatches[10]
                    case 11:
                        view.image = iphoneMatches[11]
                    case 12:
                        view.image = iphoneMatches[12]
                    case 13:
                        view.image = iphoneMatches[13]
                    case 14:
                        view.image = iphoneMatches[14]
                    case 15:
                        view.image = iphoneMatches[15]
                    case 16:
                        view.image = iphoneMatches[16]
                    case 17:
                        view.image = iphoneMatches[17]
                    case 18:
                        view.image = iphoneMatches[18]
                    case 19:
                        view.image = iphoneMatches[19]
                    default:
                        break;
                    }
                }
            }
        case 1:
            //this if else controls the timer and whether its paused or not
            if (timer?.isValid)!
            {
                timer?.invalidate()
                buttons[1].setTitle("Resume", for: .normal)
                for view in ipadContainers
                {
                    view.isUserInteractionEnabled = false
                }
            }
            else
            {
                timer = Timer(timeInterval: 1.0, target: self, selector: #selector(ViewController.count), userInfo: nil, repeats: true)
                RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
                for view in ipadContainers
                {
                    view.isUserInteractionEnabled = true
                }
                buttons[1].setTitle("Pause", for: .normal)
            }
        default:
            break
        }
    }
    //then if they are the same add to my match count flip over and disable user interaction. Once 10 or 15 matches is made depending on iphone or ipad I then dactivate the time and have my pop present
    func timerAction(){
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            if matchCount < 10{
                if matches[0].image == matches[1].image
                {
                    match()
                    taps = 0
                }
                else
                {
                    ipadContainers[holder1].isUserInteractionEnabled = true
                    ipadContainers[holder2].isUserInteractionEnabled = true
                    iphoneImage[holder1].image = #imageLiteral(resourceName: "Memory")
                    iphoneImage[holder2].image = #imageLiteral(resourceName: "Memory")
                    taps = 0
                }
                matches.removeAll()
                if matchCount == 10{
                    win()
                }
            }
        }
        else if UIDevice.current.userInterfaceIdiom == .pad
        {
            if matchCount < 15{
                if matches[0].image == matches[1].image
                {
                    match()
                }
                else
                {
                    ipadContainers[holder1].isUserInteractionEnabled = true
                    ipadContainers[holder2].isUserInteractionEnabled = true
                    ipadImage[holder1].image = #imageLiteral(resourceName: "Memory")
                    ipadImage[holder2].image = #imageLiteral(resourceName: "Memory")
                }
                matches.removeAll()
                
                if matchCount == 15{
                    win()
                }
            }
        }
    }
    
    func match(){
        matchCount += 1
        iphoneImage[holder1].image = nil
        iphoneImage[holder1].backgroundColor = UIColor(red: 34/255, green: 179/255, blue: 163/255, alpha: 1)
        iphoneImage[holder2].image = nil
        iphoneImage[holder2].backgroundColor = UIColor(red: 34/255, green: 179/255, blue: 163/255, alpha: 1)
        iphoneImage[holder1].isUserInteractionEnabled = false
        iphoneImage[holder2].isUserInteractionEnabled = false
    }
    
    func win(){
        timer?.invalidate()
        time = labels[0].text!
        let alert = UIAlertController(title: "You Win!", message: "Final Time: \(time)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textField) in
            textField.text = "Enter Your Initials!"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self](action: UIAlertAction!) in
            self?.initials = (alert.textFields![0].text)!
            self?.performSegue(withIdentifier: "highscores", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
        buttons[0].isEnabled = true
        buttons[0].setTitle("Play", for:.normal)
        counter = -1
        count()
        matchCount = 0
        setup()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "highscores"
        {
            let now = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.none
            dateFormatter.dateStyle = DateFormatter.Style.short
            let nextScreen =  segue.destination as! SecondViewController
            newScore.setValue(initials, forKey: "initial")
            newScore.setValue(time, forKey: "time")
            newScore.setValue(String(dateFormatter.string(from:now)), forKey: "date")
            newScore.setValue(moves, forKey: "move")
            nextScreen.timeLabel = time
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
    }
    //Once and image is tapped I check the count if it is the first match I add to my array, once there are two I compare there images
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        taps += 1
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            let view = tapGestureRecognizer.view
            if taps == 2{
                view?.isUserInteractionEnabled = false
            }
            print(view!.tag)
            if matches.count == 0{
                ipadImage[(view?.tag)!].image = ipadMatches[(view?.tag)!]
                holder1 = (view?.tag)!
                matches.append(ipadImage[(view?.tag)!])
            }
            else if matches.count == 1{
                ipadImage[(view?.tag)!].image = ipadMatches[(view?.tag)!]
                sleep(UInt32(0.5))
                holder2 = (view?.tag)!
                matches.append(ipadImage[(view?.tag)!])
                _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerAction), userInfo: nil, repeats: false)
            }
        }
        else if UIDevice.current.userInterfaceIdiom == .phone
        {
            let view = tapGestureRecognizer.view
            if taps == 2{
                view?.isUserInteractionEnabled = false
            }
            
            if matches.count == 0{
                iphoneImage[(view?.tag)!].image = iphoneMatches[(view?.tag)!]
                holder1 = (view?.tag)!
                matches.append(iphoneImage[(view?.tag)!])
            }
            else if matches.count == 1{
                iphoneImage[(view?.tag)!].image = iphoneMatches[(view?.tag)!]
                sleep(UInt32(0.5))
                holder2 = (view?.tag)!
                matches.append(iphoneImage[(view?.tag)!])
                _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerAction), userInfo: nil, repeats: false)
                moves += 1
                labels[1].text = "\(moves)"
            }
        }
    }
    // this is where I assign my gesture recognizers and enable user interaction
    func ipadFlash()
    {
        for (view,views) in zip(ipadContainers,ipadImage)
        {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(tapGestureRecognizer)
            views.image = #imageLiteral(resourceName: "Memory")
        }
    }
    // this is where I assign my gesture recognizers and enable user interaction
    func iphoneFlash()
    {
        for (view,views) in zip(iphoneContainers,iphoneImage)
        {
            views.image = #imageLiteral(resourceName: "Memory")
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    //this is where I change my timer to minutes and seconds
    func count(){
        counter += 1
        
        let minutes = String(counter / 60)
        let seconds = String(counter % 60)
        if Int(seconds)! < 10{
            labels[0].text = minutes + ":0" + seconds
        }
        else{
            labels[0].text = minutes + ":" + seconds
        }
    }
    
    //differintiate between ipad and iphone then I load my images into each set, along with setting up two seperate arrays to shuffle and then loop through each of my two card sets and assign a random number to that match. The number thts assigned also gets assigned to its corresponding tag.
    func ipadSetup()
    {
        let ipadMatchSet1 = [#imageLiteral(resourceName: "Lightbulb"),#imageLiteral(resourceName: "Brick"),#imageLiteral(resourceName: "Brain"),#imageLiteral(resourceName: "Chainsaw"),#imageLiteral(resourceName: "Saw"),#imageLiteral(resourceName: "Eye"),#imageLiteral(resourceName: "Zombie"),#imageLiteral(resourceName: "Flame"),#imageLiteral(resourceName: "Green Magic"),#imageLiteral(resourceName: "Treasure Chest"),#imageLiteral(resourceName: "Vault"),#imageLiteral(resourceName: "Casino Chip"),#imageLiteral(resourceName: "Rope"),#imageLiteral(resourceName: "Das Cool"),#imageLiteral(resourceName: "Blue Magic")];
        var ipadMatchSet2 = [UIImage]()
        ipadMatchSet2 = ipadMatchSet1
        let ipadArray1:[Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
        let ipadArray2:[Int] = [15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]
        let shuffledIpadArray1 = shuffle(array: ipadArray1)
        let shuffledIpadArray2 = shuffle(array: ipadArray2)
        for (view,number) in zip(ipadMatchSet1,shuffledIpadArray1)
        {
            ipadMatches[number] = view
        }
        for (view,number) in zip(ipadMatchSet2,shuffledIpadArray2)
        {
            ipadMatches[number] = view
        }
        for view in ipadImage
        {
            view.image = #imageLiteral(resourceName: "Memory")
        }
    }
    
    func iphoneSetup()
    {
        let iphoneMatchSet1:[UIImage] = [#imageLiteral(resourceName: "Lightbulb"),#imageLiteral(resourceName: "Brick"),#imageLiteral(resourceName: "Brain"),#imageLiteral(resourceName: "Chainsaw"),#imageLiteral(resourceName: "Saw"),#imageLiteral(resourceName: "Eye"),#imageLiteral(resourceName: "Zombie"),#imageLiteral(resourceName: "Flame"),#imageLiteral(resourceName: "Green Magic"),#imageLiteral(resourceName: "Treasure Chest")];
        var iphoneMatchSet2 = [UIImage]()
        iphoneMatchSet2 = iphoneMatchSet1
        let iphoneArray1:[Int] = [0,1,2,3,4,5,6,7,8,9]
        let iphoneArray2:[Int] = [10,11,12,13,14,15,16,17,18,19]
        let shuffledIphoneArray1 = shuffle(array: iphoneArray1)
        let shuffledIphoneArray2 = shuffle(array: iphoneArray2)
        for (view,number) in zip(iphoneMatchSet1,shuffledIphoneArray1)
        {
            iphoneMatches[number] = view
        }
        for (view,number) in zip(iphoneMatchSet2,shuffledIphoneArray2)
        {
            iphoneMatches[number] = view
        }
        for view in iphoneImage
        {
            view.image = #imageLiteral(resourceName: "Memory")
        }
        
    }
    //this is where I shuffle my cards so they are random spots every time
    func shuffle<C: MutableCollection>( array: C) -> C where C.Index == Int
    {
        var array = array
        let c = array.count as! Int
        if c < 2
        {
            return array
        }
        for i in 0..<(c - 1)
        {
            let j = Int(arc4random_uniform(UInt32(c - i))) + i
            if i != j
            {
                swap(&array[i], &array[j])
            }
        }
        return array
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

