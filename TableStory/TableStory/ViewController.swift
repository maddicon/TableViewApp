//
//  ViewController.swift
//  TableStory
//
//  Created by Pate, Maddi on 3/22/23.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "El Taco Feliz 2", address: "201 Staples Rd., San Marcos, TX 78666", desc: "Small but amazing taco place. Has more of a Tex-Mex feeling.", lat: 29.864400, long: -97.938000, imageName: "rest1"),
    Item(name: "Cheers Donuts", address: "1300 Texas Hwy 123 #101, San Marcos, TX 78666", desc: "Small family owned donut shop! Great for morning tasty treats.", lat: 29.859350, long: -97.939730, imageName: "rest2"),
    Item(name: "Rios Snacks", address: "1122 Texas Hwy 123., San Marcos, TX 78666", desc: "Small Mexican snack spot. Always has the best snacks.", lat: 29.863750, long: -97.939390, imageName: "rest3"),
    Item(name: "The Palm Cafe", address: "504 Broadway ST., San Marcos, TX 78666", desc: "Delicious food with amazing customer service! They have spectacular breakfast food!", lat: 29.860018, long: -97.940819, imageName: "rest4"),
    Item(name: "Rosie's Pizza To Go", address: "1318 Texas Hwy 123, San Marcos, TX 78666", desc: "Best to go pizza spot in San Marcos! Always freshly made and ready in no time.", lat: 29.857400, long: -97.939990, imageName: "rest5")
   
]

struct Item {
    var name: String
    var address: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    
    @IBOutlet weak var theTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      
      
      //Add image references
                    let image = UIImage(named: item.imageName)
                    cell?.imageView?.image = image
                    cell?.imageView?.layer.cornerRadius = 10
                    cell?.imageView?.layer.borderWidth = 5
                    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      
      return cell!
  }
      

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let item = data[indexPath.row]
       performSegue(withIdentifier: "ShowDetailSegue", sender: item)
     
   }
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowDetailSegue" {
          if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
              // Pass the selected item to the detail view controller
              detailViewController.item = selectedItem
          }
      }
  }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //add to ViewDidLoad, name corresponds to name of TableView
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
               let coordinate = CLLocationCoordinate2D(latitude: 29.861302, longitude: -97.938995)
               let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))
               mapView.setRegion(region, animated: true)
               
            // loop through the items in the dataset and place them on the map
                for item in data {
                   let annotation = MKPointAnnotation()
                   let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                   annotation.coordinate = eachCoordinate
                       annotation.title = item.name
                       mapView.addAnnotation(annotation)
                       }
        
        
        
        
    }


}



