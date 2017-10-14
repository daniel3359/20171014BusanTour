//
//  FullInfo.swift
//  201312435BusanMapTour
//
//  Created by D7702_09 on 2017. 10. 12..
//  Copyright © 2017년 lyw. All rights reserved.
//

import UIKit
import MapKit
class FullInfo: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMap2: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMap2.delegate = self
        var annotations = [MKPointAnnotation]()
        
        //p리스트에서 값을 찾아오는 것
        let path = Bundle.main.path(forResource: "infolist", ofType: "plist")
        print("path = \(String(describing: path))")
        
        //NS타입의 상수 선언
        let contents = NSArray(contentsOfFile: path!)
        print("path = \(String(describing: contents))")
        
        if let myItems = contents {
        //전체 핀을 꽂기 위해 for문 을 돌림
            for item in myItems {
                
                //각 킷값을 식별하여 저장함
                let address = (item as AnyObject).value(forKey: "address")
                let title = (item as AnyObject).value(forKey: "title")
                
                //geo코더 객체 선언
                let geoCoder = CLGeocoder()
                
                //주소값을 좌표로 변환
                geoCoder.geocodeAddressString(address as! String, completionHandler: { placemarks, error in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let myPlacemarks = placemarks {
                        let myPlacemark = myPlacemarks[0]
                        
                        print("placemark[0] = \(String(describing: myPlacemark.name))")
                
                        //같은 방법으로 핀의 정보 설정
                        let annotation = MKPointAnnotation()
                        annotation.title = title as? String
                        annotation.subtitle = address as? String
                        
                        
                        
                        //annotations 배열에 정보저장
                        if let myLocation = myPlacemark.location {
                            annotation.coordinate = myLocation.coordinate
                            annotations.append(annotation)
                        }
                        
                    }
                    print("annotations = \(annotations)")
                    //핀을 꽂기
                    self.myMap2.showAnnotations(annotations, animated: true)
                    self.myMap2.addAnnotations(annotations)
                    
                })
            }
        } else {
           
        }
    }

   
    

    

}
