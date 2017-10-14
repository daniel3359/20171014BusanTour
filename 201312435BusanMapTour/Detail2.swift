//
//  Detail2.swift
//  201312435BusanMapTour
//
//  Created by D7702_09 on 2017. 10. 12..
//  Copyright © 2017년 lyw. All rights reserved.
//

import UIKit
import MapKit
class Detail2: UIViewController, MKMapViewDelegate{
    
    //segue 에서 받아오기 위한 변수들을 선언한다
    var titleInfo = ""
    var DetailInfo = ""
    
    //맵뷰 아울렛 선언
    @IBOutlet weak var myMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        myMap.delegate = self
        var annotations = [MKPointAnnotation]()
        
        //주소값을 좌표값으로 바꾸기위한 geoCoder객체 선언
        let geoCoder = CLGeocoder()
        //segue로 받아온 값(주소) 값을 인자로 넣어서 변환한다
        geoCoder.geocodeAddressString(DetailInfo as! String, completionHandler: { placemarks, error in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let myPlacemarks = placemarks {
                let myPlacemark = myPlacemarks[0]
                
                print("placemark[0] = \(String(describing: myPlacemark.name))")
                
                //핀 객체을 선언한다
                let annotation = MKPointAnnotation()
                //핀에대한 정보(제목,부제목) 을 설정한다
                annotation.title = self.titleInfo as? String
                annotation.subtitle = self.DetailInfo as? String
                
                
                
                //annotations배열에 핀정보저장
                if let myLocation = myPlacemark.location {
                    annotation.coordinate = myLocation.coordinate
                    annotations.append(annotation)
                    
                }
                
            }
            print("annotations = \(annotations)")
            //맵에 핀을 표시해준다
            self.myMap.showAnnotations(annotations, animated: true)
            
            self.myMap.addAnnotations(annotations)
            
        })
        
        
    }


}
