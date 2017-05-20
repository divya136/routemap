//
//  ViewController.h
//  objc_map
//
//  Created by Guna Sundari on 08/05/17.
//  Copyright © 2017 Guna Sundari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate>
@property NSMutableArray *detailedSteps;

@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *routebtn;
@property (nonatomic,strong) CLLocationManager *locationManager;
- (IBAction)drawRoute:(id)sender;
@end

