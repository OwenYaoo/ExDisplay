//
//  ContactsViewController.swift
//  swif_tableView
//
//  Created by mapbarDaLian on 16/4/8.
//  Copyright © 2016年 owenyao. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CNContactPickerDelegate,UISearchBarDelegate{
    

    var contacts = [CNContact]()
    var widthBorder : CGFloat = 30
    var heightBorder : CGFloat = 20
    var contactArray = NSMutableArray()
    var rowArr = NSArray()
    var sectionArr = NSArray()
    var searchBar : UISearchBar
    
    let numLabelArr = NSMutableArray()
    let screenRate = UIScreen.screens()[1].bounds.width/UIScreen.screens()[0].bounds.width
    
    private var contactsView : ContactsView
    

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        contactsView = ContactsView(frame: CGRectZero)
        searchBar = UISearchBar.init(frame: CGRectMake(0, 0, 300, 34*screenRate))
        searchBar.backgroundColor = UIColor.whiteColor()
      //  searchBar.tintColor =  UIColor.init(red: 0.20392, green: 0.19607, blue: 0.61176, alpha: 0)
        self.searchBar.autocorrectionType = .No
        self.searchBar.autocapitalizationType = .None
        self.searchBar.keyboardType = .Alphabet
        
        ((searchBar.subviews as NSArray ).objectAtIndex(0).subviews as NSArray) .objectAtIndex(0).removeFromSuperview()

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        self.view = contactsView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "搜索联系人"
        self.contactsView.contactsTableView.tableHeaderView = searchBar
       self.contactsView.contactsTableView.tableHeaderView?.backgroundColor = UIColor.clearColor()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
             self.contacts = self.findContacts()
            
            dispatch_async(dispatch_get_main_queue()) {
                
               self.handleContactsData()
               self.contactsView.contactsTableView.sectionIndexColor = UIColor.whiteColor()
               self.contactsView.contactsTableView.sectionIndexBackgroundColor = UIColor.clearColor()
            
            }
            
        }

        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    func handleContactsData(){
        for contact:CNContact in contacts {
           let contactMode = ContactModel()
            contactMode.name = "\(contact.givenName)\(contact.familyName)"
            contactMode.picture = contact.imageData
            let numberDic = NSMutableDictionary()
            var numberType = ""

            for number in contact.phoneNumbers {
                print(number.label)
                let phoneNumber = number.value as! CNPhoneNumber
                
                if number.label == "_$!<Mobile>!$_"
                {
                   numberType = "手机:"
                }else if number.label == "_$!<Home>!$_"
                {
                   numberType = "住宅:"
                }else if number.label == "_$!<Work>!$_"
                {
                   numberType = "工作:"
                }else if number.label == "_$!<Other>!$_"
                {
                   numberType = "其他:"
                }else if number.label == "iPhone"
                {
                  
                  numberType = "iPhone:"
                }
                
                numberDic.setValue(phoneNumber.stringValue, forKey:numberType)
             
            
            }
            contactMode.address = contact.note
            
            contactMode.telephones = numberDic
            contactArray.addObject(contactMode)
           // print(contactMode.name)
        }
        contactsView.contactsTableView.delegate = self
        contactsView.contactsTableView.dataSource = self
        rowArr=ContactDataHelper.getFriendListDataBy(contactArray)
        sectionArr=ContactDataHelper.getFriendListSectionBy(rowArr.mutableCopy() as! NSMutableArray);
        contactsView.contactsTableView.reloadData()

    }
    

    func findContacts() -> [CNContact] {
        
        let store = CNContactStore()
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),
                           CNContactImageDataKey,
                           CNContactUrlAddressesKey,
                           CNContactNoteKey,
                           CNContactPhoneNumbersKey]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        
        var contacts = [CNContact]()
        
        do {
            
            try store.enumerateContactsWithFetchRequest(fetchRequest, usingBlock: { (let contact, let stop) -> Void in
                
                contacts.append(contact)
                
            })
            
        }
            
        catch let error as NSError {
            
            print(error.localizedDescription)
            
        }
        
        return contacts
        
        
    }
    //MARK:- 动态加载联系人信息页面的电话UI
    
    func reloadContactPhoneNumUI(phoneNumCount : NSInteger) {
        
        self.removeNumLabelFromView(numLabelArr, supView: contactsView.infoScrollView)
        numLabelArr.removeAllObjects()
        for i  in 0  ..< phoneNumCount  {
            //电话类型
            let phoneTypeLabel = UILabel()
            let labelGroupArr = NSMutableArray()
            phoneTypeLabel.frame = CGRectMake(10.0, 10.0 * (CGFloat(Float(i)) + 1)  + CGFloat(Float(i))*30, 100*screenRate, 30*screenRate)
            contactsView.infoScrollView.addSubview(phoneTypeLabel)
            phoneTypeLabel.textColor = UIColor.whiteColor()
            labelGroupArr.addObject(phoneTypeLabel)
           //对应电话号码
            let phoneNumLabel = UILabel()
            phoneNumLabel.frame = CGRectMake(110, 10.0 * (CGFloat(Float(i)) + 1)  + CGFloat(Float(i))*30, 200*screenRate, 30*screenRate)
            contactsView.infoScrollView.addSubview(phoneNumLabel)
            phoneNumLabel.textColor = UIColor.whiteColor()
            labelGroupArr.addObject(phoneNumLabel)
            
            numLabelArr.addObject(labelGroupArr)
            
        }
        
    }
    //MARK:- 移除电话信息label
    func removeNumLabelFromView(viewArr : NSArray , supView : UIView) {
        if viewArr.count != 0  {
            for  childViewArr in viewArr  {
                for view in (childViewArr as? NSArray)! {
                    view.removeFromSuperview()
                }
            }
        }
    }


    //MARK:- tableView Delegate and DataSource
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView  = UIView(frame:CGRectMake(0,0,tableView.frame.width,20))
        sectionView.backgroundColor = UIColor.clearColor()
        let label = UILabel(frame: CGRectMake(10,0,60,20))
        label.textAlignment = NSTextAlignment.Center
        label.text = sectionArr[section+1] as? String
        label.backgroundColor = UIColor.whiteColor()
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textColor = UIColor.blackColor()
        sectionView.addSubview(label)
        print(sectionArr[section])
        return sectionView
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 22
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 20*screenRate
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return sectionArr as? [String]
    }
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
         return  index - 1
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         return rowArr.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  rowArr[section].count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIndentifer = "indentifer"
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIndentifer)
        let contactobj = rowArr.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel?.text = contactobj.name
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.clearColor()
        cell.imageView?.image = UIImage.init(named: "white.png")
        cell.imageView?.highlightedImage = UIImage.init(named: "yellow.png")
        cell.imageView?.hidden = true
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let contactobj : ContactModel = rowArr.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! ContactModel
        if contactobj.picture != nil {
            contactsView.photoImage.image = UIImage.init(data:contactobj.picture)

        }else{
            contactsView.photoImage.image = UIImage.init(named: "default_man.png")
        }
        contactsView.nameLabel.text = contactobj.name
        self.reloadContactPhoneNumUI(contactobj.telephones.count)
        for arr in 0  ..< numLabelArr.count {
            
            (numLabelArr.objectAtIndex(arr).firstObject() as? UILabel)!.text = (contactobj.telephones.allKeys as NSArray).objectAtIndex(arr) as? String
            (numLabelArr.objectAtIndex(arr).lastObject() as? UILabel)!.text = (contactobj.telephones.allValues as NSArray).objectAtIndex(arr) as? String
            
        }
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.imageView?.hidden = false
        cell?.imageView?.highlighted = true
        cell?.textLabel?.textColor = UIColor.yellowColor()
        
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.textLabel?.textColor = UIColor.whiteColor()
        cell?.imageView?.highlighted = false
        cell?.imageView?.hidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.\
     1.Party Shaker (Video Edit) 2.Supernova (R.I.O. Radio Edit) 3.Ready Or Not(Video Edit) 4.Living In Stereo 5.Turn this club around 6.Shine on 7.Like I love you 8.Good Vibe 9.Summer Jam 10.Miss Sunshine 11.Rock This Club (R.I.O. Radio Edit)
     12.De Janeiro 13.Children Of The Sun 14.Animal 15.1.2.3.4 16.When The Sun Comes Down 17.Je ne sais pas 18.Hot Girl 19.My life is a party 20.Serenade 21.After the love  22.Can You Feel it 23.Lay Down 24.One Heart
    }
    */

}
