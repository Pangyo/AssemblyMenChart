//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by KimHyo kook on 2016. 3. 20..
//  Copyright © 2016년 Hyokook KIM. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UITableViewController, NSXMLParserDelegate {
    
    var list = Array<AssemblymanVO>()
    var posts = NSMutableArray()
    var parser = NSXMLParser()
    var elements = NSMutableDictionary()
    var element = NSString()
    var name = NSMutableString()
    var reeleGbnNm = NSMutableString()
    var jpgLink = NSMutableString()
    var location = NSMutableString()
    var deptCd = NSMutableString()
    var mvo : AssemblymanVO = AssemblymanVO()
    var page : Int = 2
    var selectRow : Int = 0
    var Detail = DetailView()
    
    override func viewDidLoad() {
        
        posts = []

        beginparsing()
        
        
    }

    @IBOutlet var moreTable: UITableView!
    
    @IBAction func more(sender: AnyObject) {
        
        beginparsing(page++)
        
        self.moreTable.reloadData()
    }

    func beginparsing(page:Int = 1)
    {
        
        var apiURI = NSURL(string: "http://apis.data.go.kr/9710000/NationalAssemblyInfoService/getMemberCurrStateList?ServiceKey=gm9EiTUcjCNgVPZfmCXoi1r3SWqTiyqKbpa7%2FkaLRNqgKu60WbYwh0n7iPf5XdcU8mc0G0MoE1RRmz4nNZsezQ%3D%3D&pageNo=\(page)")
        
        
        var apidata : NSData? = NSData(contentsOfURL: apiURI!)
        
        var amvo : AssemblymanVO
        
        NSLog("API Result = %@", NSString(data: apidata!, encoding: NSUTF8StringEncoding)!)
        
        //posts = []
        
        parser = NSXMLParser(data: apidata!)
        
        parser.delegate = self
        
        parser.parse()
        

        for row in self.posts{
            amvo = AssemblymanVO()
            amvo.Kname = row["name"] as? String
            amvo.origNm = row["origNm"] as? String
            amvo.reeleGbNm = row["reeleGbNm"] as? String
            amvo.thumbnail = row["jpgLink"] as? String
            self.list.append(amvo)
        }
        

        
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqualToString("item"){
            if !deptCd.isEqual(nil){
                elements.setObject(deptCd, forKey: "deptCd")
            }
            if !name.isEqual(nil){
                elements.setObject(name, forKey: "name")
            }
            if !reeleGbnNm.isEqual(nil){
                elements.setObject(reeleGbnNm, forKey: "reeleGbNm")
            }
            if !jpgLink.isEqual(nil){
                elements.setObject(jpgLink, forKey: "jpgLink")
            }
            if !location.isEqual(nil){
                elements.setObject(location, forKey: "origNm")
            }
            posts.addObject(elements)
           
        }
    
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if element.isEqualToString("deptCd"){
            deptCd.appendString(string)
        } else if element.isEqualToString("empNm"){
            name.appendString(string)
        }else if element.isEqualToString("reeleGbnNm"){
            reeleGbnNm.appendString(string)
        } else if element.isEqualToString("jpgLink"){
            jpgLink.appendString(string)
        } else if element.isEqualToString("origNm"){
            location.appendString(string)
        }
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        if (element as NSString).isEqualToString("item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            name = NSMutableString()
            name = ""
            reeleGbnNm = NSMutableString()
            reeleGbnNm = ""
            jpgLink = NSMutableString()
            jpgLink = ""
            location = NSMutableString()
            location = ""
            deptCd = NSMutableString()
            deptCd = ""
        }
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        NSLog("이름:\(row.Kname!) 호출된 행 번호:\(indexPath.row)")
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell") as! MovieCell /*재사용 큐에서 할당받아 cell을 생성*/
        
        cell.title?.text = row.Kname!
        cell.desc?.text = row.origNm!
        cell.opendate?.text = row.reeleGbNm!
        //cell.rating?.text = "\(row.rating!)"
        
        dispatch_async(dispatch_get_main_queue(),{
            NSLog("비동기 방식")
            cell.thumbnail?.image = self.getthumbnailImage(indexPath.row)
        }) /*비동기 처리*/
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="segue_detail"){ //bug
            let indexPath = self.moreTable.indexPathForCell(sender as! MovieCell)/*차후 변경 예정 MovieCell*/
            Detail = (segue.destinationViewController as? DetailView)!
            Detail.department_num = (self.posts[indexPath!.row]["deptCd"] as? String)!
            NSLog("Touch Table Row at %d", indexPath!.row)
        }
        
      
    }
    
    func getthumbnailImage(index : Int) -> UIImage{
        let amvo = self.list[index]
        
        if let savedImage = amvo.thumnailImage{
            return savedImage
        } else {
            var url = NSURL(string: amvo.thumbnail!)
            let imageData = NSData(contentsOfURL: url!)
            amvo.thumnailImage = UIImage(data: imageData!)
            return amvo.thumnailImage!
        }
    }
    
}