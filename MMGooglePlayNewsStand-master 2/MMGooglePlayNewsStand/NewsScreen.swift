//
//  MMSampleTableViewController.swift
//  MMGooglePlayNewsStand
//
//  Created by mukesh mandora on 25/08/15.
//  Copyright (c) 2015 madapps. All rights reserved.
//

import UIKit

@objc protocol scrolldelegateForYAxis{
    
    @objc optional func scrollYAxis(offset:CGFloat , translation:CGPoint)              // If the skipRequest(sender:) action is connected to a button, this function is called when that button is pressed.
    
    @objc optional func getframeindexpathOfController()->CGRect
}

var titleToPass : [String] = []
var idToPass : [String] = []
var entityToPass : [String] = []
var counter = 0
var title_1 : String = ""

class MMSampleTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MMPlayPageScroll ,UIScrollViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    let header: UIView!
    let headerImage: UIImageView!
    var trans:CGPoint
    var imageArr:[UIImage]!
    var transitionManager : TransitionModel!
    var preventAnimation = Set<NSIndexPath>()
    
    //     weak var scrolldelegate:scrolldelegateForYAxis?
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var tag = 0 as Int
    override func viewDidLoad() {
        counter++

        transitionManager = TransitionModel()
        super.viewDidLoad()
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.decelerationRate=UIScrollViewDecelerationRateFast
        header.frame=CGRectMake(0, 0, self.view.frame.width, 250);
        //headerImage.frame=CGRectMake(header.center.x-30, header.center.y-30, 60, 60)
        //headerImage.layer.cornerRadius=headerImage.frame.width/2
        
        
       
        headerImage.tintColor=UIColor.whiteColor()
        
        
        header.backgroundColor=UIColor.clearColor()
        
        //        header.addSubview(headerImage)
        initHeadr()
        self.view.addSubview(headerImage)
        self.tableView.tableHeaderView=header;
        // Do any additional setup after loading the view.
        self.setNeedsStatusBarAppearanceUpdate()
        
        imageArr.append(UIImage(named: "bernie-final")!)
        imageArr.append(UIImage(named: "worldbg.jpg")!)
        imageArr.append(UIImage(named: "sportsbg.jpg")!)
        imageArr.append(UIImage(named: "applebg.png")!)
        imageArr.append(UIImage(named: "businessbg.jpg")!)
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        header=UIView()
        headerImage=UIImageView()
        headerImage.backgroundColor=UIColor(hexString: "109B96")
        headerImage.contentMode=UIViewContentMode.Center
        headerImage.clipsToBounds=true
        trans=CGPointMake(0, 0)
        imageArr = Array()
        super.init(coder: aDecoder)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func initHeadr(){
        //header Color
  
        switch ( tag){
        case 1:  
            break
            
        case 2:
             headerImage.backgroundColor=UIColor(hexString: "009688")
              headerImage.image=UIImage(named: "sports")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        case 3:
             headerImage.backgroundColor=UIColor(hexString: "673ab7")
              headerImage.image=UIImage(named: "movie")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        case 4:
             headerImage.backgroundColor=UIColor(hexString: "ff9800")
              headerImage.image=UIImage(named: "tech")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        case 5:
             headerImage.backgroundColor=UIColor(hexString: "03a9f4")
              headerImage.image=UIImage(named: "business")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        default:
             headerImage.backgroundColor=UIColor(hexString: "4caf50")
              headerImage.image=UIImage(named: "world")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if !preventAnimation.contains(indexPath) {
            preventAnimation.insert(indexPath)
            TipInCellAnimator.animate(cell)
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:NewsCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! NewsCellTableViewCell
        if(counter % 2 != 0)
        {
            cell.titleNews.text = titleToPass[indexPath.row]
        }
        else if(counter % 2 == 0)
        {
            cell.titleNews.text = first3Entities[indexPath.row]
        }
        else
        {
            cell.titleNews.text = "what"
        }
        //cell.useText(indexPath.row + 1)
        /*
        if(NSUserDefaults.standardUserDefaults().boolForKey("displayEntities") == true)
        {
            cell.titleNews.text = first3Entities[indexPath.row]
            println("hey")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "displayEntities")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        else
        {
            cell.titleNews.text = titleToPass[indexPath.row]
        }
*/
        //cell.headerImage.image=imageArr[indexPath.row]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(counter % 2 == 0)
        {
            titleToPass = []
            entityToPass = []
            idToPass = []
            SwiftSpinner.show("Loading...", animated: true)
            request(.GET, "http://104.236.159.247:8181/top", parameters: ["term": first3Entities[indexPath.row]]).responseJSON {
                (request, response, json, error) in
                var json = JSON(json!);
                let count = json.arrayValue.count
                for i in 0..<count
                {
                    var subjson = json.arrayValue[i]
                    
                    var title = subjson["title"].stringValue
                    var entitieValues: [String] = subjson["entities"].arrayValue.map{ $0.stringValue}
                    first3Entities = Array(entitieValues[0..<3])
                    //entities.append(first3Entities)
                    
                    var id: String = subjson["id"].stringValue
                    
                    titleToPass.append(title)
                    entityToPass += first3Entities
                    idToPass.append(id)
                }
                //title1 = self.textField.text
                title_1 = titleToPass[indexPath.row]
                SwiftSpinner.hide()
                ViewController().initPlayStand()
            }
        }
        else if(counter % 2 != 0)
        {
            newId = idToPass[indexPath.row]
            self.performSegueWithIdentifier("moveToAudioPage", sender: self)
        }
        //Patrick, this is where you segue to the audio.
        /*
        let detail = self.storyboard?.instantiateViewControllerWithIdentifier("detail") as! DetailViewController
        detail.modalPresentationStyle = UIModalPresentationStyle.Custom;
        detail.transitioningDelegate = transitionManager;
        appDelegate.walkthrough?.presentViewController(detail, animated: true, completion: nil)
//        self.presentViewController(detail, animated: true, completion: nil)
*/

    }
    
    //MARK:  - Scroll delegate
    
    func walkthroughDidScroll(position:CGFloat, offset:CGFloat) {
        //        NSLog("In controller%f %f", offset,position)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        trans = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y);
        appDelegate.walkthrough!.scrollYAxis(scrollView.contentOffset.y, translation: trans)
    }
    
    
    
    
}
