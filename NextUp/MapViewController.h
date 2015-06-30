//
//  MapViewController.h
//  NextUp
//
//  Created by Michael Lee on 4/10/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>



@interface MapViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak,nonatomic)  MKAnnotationView *annotationView;
@property (strong ,nonatomic) MKAnnotationView *brookhavenView ;
@property (strong ,nonatomic) PFGeoPoint *userLocation;
@property (strong,nonatomic) CLLocationManager *locationManager;














@end
