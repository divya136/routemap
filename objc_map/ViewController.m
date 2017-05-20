//
//  ViewController.m
//  objc_map
//
//  Created by Guna Sundari on 08/05/17.
//  Copyright © 2017 Guna Sundari. All rights reserved.
//

#import "ViewController.h"
#import "MDDirectionService.h"

@interface ViewController ()

@end

@implementation ViewController
{
//    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSMutableString *title;
    NSMutableString *snippet;
    CLLocationCoordinate2D origincoordinate;
    CLLocationCoordinate2D destinationcoordinate;
    NSMutableString *jsonpoints;
    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_;

}
//- (void)loadView {
//    waypoints_ = [[NSMutableArray alloc]init];
//    waypointStrings_ = [[NSMutableArray alloc]init];
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:37.778376
//                                                            longitude:-122.409853
//                                                                 zoom:13];
//    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//    _mapView.delegate = self;
//    self.view = _mapView;
//    
//}
//
//- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:
//(CLLocationCoordinate2D)coordinate {
//    
//    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(
//                                                                 coordinate.latitude,
//                                                                 coordinate.longitude);
//    GMSMarker *marker = [GMSMarker markerWithPosition:position];
//    marker.map = mapView;
//    [waypoints_ addObject:marker];
//    NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
//                                coordinate.latitude,coordinate.longitude];
//    [waypointStrings_ addObject:positionString];
//    if([waypoints_ count]>1){
//        NSString *sensor = @"false";
//        NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
//                               nil];
//        NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
//        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
//                                                          forKeys:keys];
//        MDDirectionService *mds=[[MDDirectionService alloc] init];
//        SEL selector = @selector(addDirections:);
//        [mds setDirectionsQuery:query
//                   withSelector:selector
//                   withDelegate:self];
//    }
//}
//- (void)addDirections:(NSDictionary *)json {
//    
//    NSDictionary *routes = [json objectForKey:@"routes"][0];
//    
//    NSDictionary *route = [routes objectForKey:@"overview_polyline"];
//    NSString *overview_route = [route objectForKey:@"points"];
//    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
//    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
//    polyline.map = _mapView;
//}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
                [self.locationManager requestAlwaysAuthorization];
            }
        }
        [self.locationManager startUpdatingLocation];
    } else {
        NSLog(@"Location services are not enabled");
    }
    
    
   
    
    self.mapView.myLocationEnabled = YES;
    
    //Controls the type of map tiles that should be displayed.
    
    self.mapView.mapType = kGMSTypeNormal;
    
    //Shows the compass button on the map
    
    self.mapView.settings.compassButton = YES;
    
    //Shows the my location button on the map
    
    self.mapView.settings.myLocationButton = YES;
    
    //Sets the view controller to be the GMSMapView delegate
    
    self.mapView.delegate = self;
    
    CLLocation *location = [self.locationManager location];
    
    
    CLLocationCoordinate2D coordinate = [location coordinate];
    origincoordinate = [location coordinate];
    
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    //NSLog(@”dLatitude : %@”, latitude);
    //NSLog(@”dLongitude : %@”,longitude);
    NSLog(@"MY HOME :%@", latitude);
    NSLog(@"MY HOME: %@ ", longitude);
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.appearAnimation=YES;
    marker.position = CLLocationCoordinate2DMake(12.98, 80.12);
    marker.map = self.mapView;
    
   
    
}


- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self.mapView clear];

    GMSMarker *marker3 = [[GMSMarker alloc] init];
    marker3.position = coordinate;
   
    
    destinationcoordinate = coordinate;
    
    NSLog(@"marker coor :%f", coordinate.latitude);
    NSLog(@"marker long: %f ", coordinate.longitude);
    
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [ceo reverseGeocodeLocation: loc completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         NSLog(@"placemark %@",placemark);
         //String to hold address
         NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         NSLog(@"addressDictionary %@", placemark.addressDictionary);
         
         NSLog(@"placemark %@",placemark.region);
         NSLog(@"placemark %@",placemark.country);  // Give Country Name
         NSLog(@"placemark %@",placemark.locality); // Extract the city name
         NSLog(@"location %@",placemark.name);
         NSLog(@"location %@",placemark.ocean);
         NSLog(@"location %@",placemark.postalCode);
         NSLog(@"location %@",placemark.subLocality);
         
         NSLog(@"location %@",placemark.location);
         //Print the location to console
         NSLog(@"I am currently at %@",locatedAt);
         title = [NSMutableString stringWithString: placemark.subLocality];
         snippet = [NSMutableString stringWithString: locatedAt];
            }];
         
    marker3.title = title;
    marker3.snippet = snippet;
    marker3.map = self.mapView;
}

//- (void) getAddressFromLatLon:(CLLocation *)bestLocation
//{
//    NSLog(@"%f %f", bestLocation.coordinate.latitude, bestLocation.coordinate.longitude);
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
//    [geocoder reverseGeocodeLocation:bestLocation
//                   completionHandler:^(NSArray *placemarks, NSError *error)
//     {
//         if (error){
//             NSLog(@"Geocode failed with error: %@", error);
//             return;
//         }
//         CLPlacemark *placemark = [placemarks objectAtIndex:0];
//         NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
//         NSLog(@"locality %@",placemark.locality);
//         NSLog(@"postalCode %@",placemark.postalCode);
//         
//     }];
//    
//}


- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}

- (void) mapView:(GMSMapView *)mapView didBeginDraggingMarker:(GMSMarker *)marker{
    //isDragging = YES;
    NSLog(@"didBeginDraggingMarker:");
}

- (void)mapView:(GMSMapView *)mapView didEndDraggingMarker:(GMSMarker *)marker{
    //isDragging = NO;
    NSLog(@"marker dragged to location: %f,%f", marker.position.latitude, marker.position.longitude);
    
    NSLog(@"didEndDraggingMarker");
    
}

#pragma mark – draw route methods

//- (void)drawRoute
- (IBAction)drawRoutee:(id)sender
{
//    [self fetchPolylineWithOrigin:origincoordinate destination:destinationcoordinate completionHandler:^(GMSPolyline *polyline)
//     {
//         if(polyline)
//             polyline.map = self.mapView;
//     }];
    
    //NSString *urlString = [NSString stringWithFormat:@"%@?origin=%@,%@&destination=%f,%f&sensor=false&waypoints=optimize:true&mode=driving", @"https://maps.googleapis.com/maps/api/directions/json", getmycurrlat, getmycurrlong, LATI, LONGI];
    //NSLog(@"my driving api URL --- %@", urlString);
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?&origin=%f,%f&destination=13.00473455,80.11590400&mode=driving",origincoordinate.latitude,origincoordinate.longitude];

    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@", urlString]];
    NSURLResponse* res;
    NSError* err;
    NSData* data = [NSURLConnection sendSynchronousRequest:[[NSURLRequest alloc] initWithURL:url] returningResponse:&res error:&err];
    if (data == nil) {
        return;
    }
    
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary* routes = [dic objectForKey:@"routes"][0];
    NSDictionary* route = [routes objectForKey:@"overview_polyline"];
    NSString* overview_route = [route objectForKey:@"points"];
    
    GMSPath* path = [GMSPath pathFromEncodedPath:overview_route];
    GMSPolyline* polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeWidth = 5;
//      polyline.strokeColor = COLOR_GREEN;

    polyline.map = self.mapView;
}

- (void)fetchPolylineWithOrigin:(CLLocation *)origin destination:(CLLocation *)destination completionHandler:(void (^)(GMSPolyline *))completionHandler
{

    NSString *originString = [NSString stringWithFormat:@"%f,%f", 80.127476, 12.985155];
    NSString *destinationString = [NSString stringWithFormat:@"%f,%f", 80.45, 12.12];
    NSString *directionsAPI = @"https://maps.googleapis.com/maps/api/directions/json?";
    NSString *directionsUrlString = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&mode=driving", directionsAPI, originString, destinationString];
    //NSURL *directionsUrl = [NSURL URLWithString:directionsUrlString];
    
    NSURL *directionsUrl = [NSURL URLWithString:@"https://maps.googleapis.com/maps/api/directions/json?&origin=12.98869090,80.12946410&destination=13.00473455,80.11590400&mode=driving"];

    NSURLSessionDataTask *fetchDirectionsTask = [[NSURLSession sharedSession] dataTaskWithURL:directionsUrl completionHandler:
                                                 ^(NSData *data, NSURLResponse *response, NSError *error)
                                                 {
                                                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                     if(error)
                                                     {
                                                         if(completionHandler)
                                                             completionHandler(nil);
                                                         return;
                                                     }
                                                     
                                                     NSArray *routesArray = [json objectForKey:@"routes"];
                                                     
                                                     GMSPolyline *polyline = nil;
                                                     if ([routesArray count] > 0)
                                                     {
                                                         NSDictionary *routeDict = [routesArray objectAtIndex:0];
                                                         NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
                                                         NSString *points = [routeOverviewPolyline objectForKey:@"points"];
                                                         jsonpoints = [NSMutableString stringWithString: points];

                                                         //GMSPath *path = [GMSPath pathFromEncodedPath:points];
                                                         //polyline = [GMSPolyline polylineWithPath:path];
                                                     }
                                                     
                                                     // run completionHandler on main thread                                           
                                                     dispatch_sync(dispatch_get_main_queue(), ^{
                                                         GMSPath *path = [GMSPath pathFromEncodedPath:jsonpoints];
                                                         GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
                                                         polyline.strokeWidth = 5.f;
                                                         polyline.map = self.mapView;
                                                         if(completionHandler)
                                                             completionHandler(polyline);
                                                     });
                                                 }];
   
    [fetchDirectionsTask resume];
}


#pragma mark – CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"%f",location.coordinate.latitude);
    NSLog(@"%f",location.coordinate.longitude);
[self.locationManager stopUpdatingLocation];
    //self.latitudeValue.text = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    //self.longtitudeValue.text = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)drawRoute:(id)sender {
    //NSURL *url=[[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=chrompet&destination=pammal"]];
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?&origin=%f,%f&destination=%f,%f&mode=driving",origincoordinate.latitude,origincoordinate.longitude,destinationcoordinate.latitude,destinationcoordinate.longitude];
    
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@", urlString]];
    
    
   // NSURL *url=[[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?&origin=13.00473455,80.11590400&destination=13.11473455,80.21590400&mode=driving"]];
    NSURLResponse *res;
    NSError *err;
    NSData *data=[NSURLConnection sendSynchronousRequest:[[NSURLRequest alloc] initWithURL:url] returningResponse:&res error:&err];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *routes=dic[@"routes"];
    NSArray *legs=routes[0][@"legs"];
    NSArray *steps=legs[0][@"steps"];
    NSMutableArray *textsteps=[[NSMutableArray alloc] init];
    NSMutableArray *latlong=[[NSMutableArray alloc]init];
    for(int i=0; i< [steps count]; i++){
        NSString *html=steps[i][@"html_instructions"];
        [latlong addObject:steps[i][@"end_location"]];
        [textsteps addObject:html];
    }
    self.detailedSteps=textsteps;
    [self showDirection:latlong];
}
-(void)showDirection:(NSMutableArray*) latlong{
    GMSMutablePath *path = [GMSMutablePath path];
    for(int i=0; i<[latlong count]; i++){
        double lat=[latlong[i][@"lat"] doubleValue];
        double lng=[latlong[i][@"lng"] doubleValue];
        [path addLatitude:lat longitude:lng];
    }
    NSLog(@"Direction path");
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = [UIColor blueColor];
    polyline.strokeWidth = 5.f;
    polyline.map = self.mapView ;
    
}
@end
