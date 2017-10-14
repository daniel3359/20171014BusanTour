//
//  ViewController.swift
//  201312435BusanMapTour
//
//  Created by D7702_09 on 2017. 10. 12..
//  Copyright © 2017년 lyw. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //NS타입의 배열을 생성한다
    var contents = NSArray()
    //테이블뷰 아울렛 생성
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //데이터소스및 딜리게이트 연결
        myTableView.dataSource = self
        myTableView.delegate = self
        
        //p리스트 파일 찾기
        let path = Bundle.main.path(forResource: "infolist", ofType: "plist")
        print("path = \(String(describing: path))")
        
        //p리스트 파일 연결
        contents = NSArray(contentsOfFile: path!)!
        print("path = \(String(describing: contents))")
        
 
        self.title = "부산 투어"
    }
    //셀갯수 정함
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        print("\(contents.count)")
        return contents.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let myCell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        //테이블에 표시하기위해컨텐츠에서 address라는 키를 찾아 상수 address 에 저장한다
        let address = (contents[indexPath.row] as AnyObject).value(forKey: "address")
        //마찬가지로 타이틀정보를 키로 찾아서 상수 title에 저장한다
        let title = (contents[indexPath.row] as AnyObject).value(forKey: "title")
        
        
        //테이블의 셀에 각 타이틀 서브타이틀에 출력하기위해 String타입으로 
        //캐스팅하여 넣는다
        myCell.textLabel?.text = title as? String
        myCell.detailTextLabel?.text = address as? String
        
        //cell을 리턴하여 출력한다
        return myCell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //segue사용하여 goDetail이라는 식별자를 찾아서 알맞게 보낸다
        if segue.identifier == "goDetail"{
            let detailVC = segue.destination as! Detail2
            let selectedPath = myTableView.indexPathForSelectedRow
            
            //테이블에서 선택된 내용을 컨텐츠 에서 찾아 보낸다
            let myTitle = (contents[(selectedPath?.row)!] as AnyObject).value(forKey: "title")
            let myAddress = (contents[(selectedPath?.row)!] as AnyObject).value(forKey: "address")
            detailVC.titleInfo = myTitle as! String
            detailVC.DetailInfo = myAddress as! String
        }

    


    }
}
