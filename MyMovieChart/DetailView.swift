//
//  DetailView.swift
//  MyMovieChart
//
//  Created by KimHyo kook on 2016. 4. 3..
//  Copyright © 2016년 Hyokook KIM. All rights reserved.
//

import Foundation
import UIKit

class DetailView: UIViewController, NSXMLParserDelegate {
    
    var department_num : String? = ""
    
    @IBOutlet var Kname: UILabel!
    @IBOutlet var Cname: UILabel!
    @IBOutlet var Ename: UILabel!
    @IBOutlet var PartyName: UILabel!
    @IBOutlet var memtitle: UILabel!
    @IBOutlet var HomePage: UIButton!


    //var list = Array<AssemblymanVO>()
    var posts = NSMutableArray()
    var parser = NSXMLParser()
    var elements = NSMutableDictionary()
    var element = NSString()
    var KoreanName = NSMutableString()
    var ChinaName = NSMutableString()
    var EngName = NSMutableString()
    var polyNm = NSMutableString()
    var memTitle = NSMutableString()
    
    var reeleGbnNm = NSMutableString()
    var jpgLink = NSMutableString()
    var location = NSMutableString()
    var deptCd = NSMutableString()
    var assemHomep = NSMutableString()

    override func viewDidLoad() {
        
        
        beginparsing()
        
        Kname.text? = elements["empNm"] as! String
        Cname.text? = elements["hjNm"] as! String
        Ename.text? = elements["engNm"] as! String
        PartyName.text? = elements["polyNm"] as! String
        memtitle.text? = elements["memTitle"] as! String
        HomePage.setTitle(elements["assemHomep"] as? String, forState: UIControlState.Normal)
        //HomePage.text? = elements["assemHomep"] as! String
        
    }
    
    func beginparsing(page:Int = 1)
    {
        
        let path = NSBundle.mainBundle().pathForResource("APIList", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        let DATAORG = dict!.objectForKey("DATAORG") as! String
        let Assemblyinfo = dict!.objectForKey("NationalAssemblyInfoService") as! String
        let getDlist = dict!.objectForKey("getMemberDetailInfoList") as! String
        let serviceKey = dict!.objectForKey("ServiceKey") as! String
        
        let apiURI = NSURL(string: DATAORG + Assemblyinfo + "/" + getDlist + "?" + "dept_cd=\(department_num!)&" + serviceKey)
        

        
        let apidata : NSData? = NSData(contentsOfURL: apiURI!)
        
        
        
        //NSLog("API Result = %@", NSString(data: apidata!, encoding: NSUTF8StringEncoding)!)
        
        //posts = []
        
        parser = NSXMLParser(data: apidata!)
        
        parser.delegate = self
        
        parser.parse()
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqualToString("item"){
            if !deptCd.isEqual(nil){
                elements.setObject(deptCd, forKey: "deptCd")
            }
            if !KoreanName.isEqual(nil){
                elements.setObject(KoreanName, forKey: "empNm")
            }
            if !ChinaName.isEqual(nil){
                elements.setObject(ChinaName, forKey: "hjNm")
            }
            if !EngName.isEqual(nil){
                elements.setObject(EngName, forKey: "engNm")
            }
            if !polyNm.isEqual(nil){
                elements.setObject(polyNm, forKey: "polyNm")
            }
            if !memTitle.isEqual(nil){
                elements.setObject(memTitle, forKey: "memTitle")
            }
            if !jpgLink.isEqual(nil){
                elements.setObject(jpgLink, forKey: "jpgLink")
            }
            if !location.isEqual(nil){
                elements.setObject(location, forKey: "origNm")
            }
            if !assemHomep.isEqual(nil){
                elements.setObject(assemHomep, forKey: "assemHomep")
            }
            //posts.addObject(elements)
            
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if element.isEqualToString("deptCd"){
            deptCd.appendString(string)
        }
        else if element.isEqualToString("empNm"){
            KoreanName.appendString(string)
        }
        else if element.isEqualToString("hjNm"){
            ChinaName.appendString(string)
        }
        else if element.isEqualToString("engNm"){
            EngName.appendString(string)
        }
        else if element.isEqualToString("polyNm"){
            polyNm.appendString(string)
        }
        else if element.isEqualToString("memTitle"){
            memTitle.appendString(string)
        }
        else if element.isEqualToString("jpgLink"){
            jpgLink.appendString(string)
        }
        else if element.isEqualToString("origNm"){
            location.appendString(string)
        }
        else if element.isEqualToString("assemHomep"){
            assemHomep.appendString(string)
        }
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        if (element as NSString).isEqualToString("item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            
            KoreanName = NSMutableString()
            KoreanName = ""
            ChinaName = NSMutableString()
            ChinaName = ""
            EngName = NSMutableString()
            EngName = ""
            polyNm = NSMutableString()
            polyNm = ""
            memTitle = NSMutableString()
            memTitle = ""
            reeleGbnNm = NSMutableString()
            reeleGbnNm = ""
            jpgLink = NSMutableString()
            jpgLink = ""
            location = NSMutableString()
            location = ""
            deptCd = NSMutableString()
            deptCd = ""
            assemHomep = NSMutableString()
            assemHomep = ""
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "HomePageSegue"){
            (segue.destinationViewController as? HomepageViewController)?.name = (elements["empNm"] as? String)!
            (segue.destinationViewController as? HomepageViewController)?.Homepage = elements["assemHomep"] as! String
        }
    }
}

