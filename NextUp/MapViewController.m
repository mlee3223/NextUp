//
//  MapViewController.m
//  NextUp
//
//  Created by Michael Lee on 4/10/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import "MapViewController.h"
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#include <CoreLocation/CoreLocation.h>
#import "GymInfoDetailViewController.h"





#define METERS_PER_MILE 1609.344



@interface MapViewController () <CLLocationManagerDelegate>
@end

@implementation MapViewController
@synthesize mapView;
@synthesize userLocation;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //Title Bar
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
        [UIFont fontWithName:@"GillSans-Bold" size:17.0f], UITextAttributeFont,
                                                                     [UIColor colorWithRed:0.047 green:0.965 blue:0.443 alpha:1], UITextAttributeTextColor,
                                                                     [UIColor grayColor], UITextAttributeTextShadowColor,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                                                     UITextAttributeTextShadowOffset,
                                                                     
                                                                     nil]];
    
    //TitleBar Color
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.118 green:0.133 blue:0.149 alpha:1]];
    
    mapView.delegate = self;
  
    
    
       }


-(void)viewWillAppear:(BOOL)animated
{
    
    //Replace CLLOcation code here if need be
   
    
   // NSLog(@"%@",location);
    
    MKCoordinateRegion region;
    region.center.latitude = 33.7677129;
    region.center.longitude =-84.420604;
    region.span.latitudeDelta = .3;
    region.span.longitudeDelta = .3;
    [mapView setRegion:region animated:YES];
    
    
    
    CLLocationCoordinate2D brookhaven;
    brookhaven.latitude =33.872144 ;
    brookhaven.longitude = -84.33496;
    CLLocationCoordinate2D perimeter;
    perimeter.latitude= 33.9241833;
    perimeter.longitude= -84.3475771;
    CLLocationCoordinate2D mozleyPark;
    mozleyPark.latitude=33.750969;
    mozleyPark.longitude=-84.4351781;
    CLLocationCoordinate2D AtlantaMosque;
    AtlantaMosque.latitude = 33.784678,
    AtlantaMosque.longitude=-84.401004;
    CLLocationCoordinate2D BuckheadYMCA;
    BuckheadYMCA.latitude =33.831421;
    BuckheadYMCA.longitude=-84.424819;
    CLLocationCoordinate2D Buckhead;
    Buckhead.latitude= 33.844438;
    Buckhead.longitude =-84.374171;
    CLLocationCoordinate2D AtlanticStation;
    AtlanticStation.latitude = 33.793815;
    AtlanticStation.longitude = -84.396206 ;
    CLLocationCoordinate2D Cobb;
    Cobb.latitude = 33.882146;
    Cobb.longitude = -84.458447 ;
    CLLocationCoordinate2D LaVista;
    LaVista.latitude = 33.842389;
    LaVista.longitude =-84.246205 ;
    CLLocationCoordinate2D GSURecCenter;
    GSURecCenter.latitude =33.752502;
    GSURecCenter.longitude =-84.38464 ;
    CLLocationCoordinate2D CentralPark;
    CentralPark.latitude =33.769497;
    CentralPark.longitude = -84.375808  ;
    
    
    MKPointAnnotation *brookhavenPoint = [[MKPointAnnotation alloc] init];
    brookhavenPoint.coordinate = brookhaven;
    brookhavenPoint.title = @"LAFitness Brookhaven";
    brookhavenPoint.subtitle = @"Gym";
    MKPointAnnotation *perimeterPoint = [[MKPointAnnotation alloc] init];
    perimeterPoint.coordinate = perimeter;
    perimeterPoint.title = @"LAFitness Perimeter";
    perimeterPoint.subtitle = @"Gym";
    MKPointAnnotation *mozleyParkPoint = [[MKPointAnnotation alloc]init];
    mozleyParkPoint.coordinate = mozleyPark;
    mozleyParkPoint.title = @"Mozley Park";
    MKPointAnnotation *AtlantaMosquePoint = [[MKPointAnnotation alloc] init];
    AtlantaMosquePoint.coordinate = AtlantaMosque;
    AtlantaMosquePoint.title = @"Atlanta Mosque";
    MKPointAnnotation *BuckheadYMCAPoint = [[MKPointAnnotation alloc]init];
    BuckheadYMCAPoint.coordinate = BuckheadYMCA;
    BuckheadYMCAPoint.title = @"Buckhead YMCA";
    MKPointAnnotation *BuckheadPoint =[[MKPointAnnotation alloc]init];
    BuckheadPoint.coordinate = Buckhead;
    BuckheadPoint.title = @"LAFitness Buckhead";
    MKPointAnnotation *AtlanticStationPoint =[[MKPointAnnotation alloc]init];
    AtlanticStationPoint.coordinate =AtlanticStation;
    AtlanticStationPoint.title = @"LAFitness Atlantic Station";
    MKPointAnnotation *CobbPoint= [[MKPointAnnotation alloc]init];
    CobbPoint.coordinate =Cobb;
    CobbPoint.title = @"LAFitness Cobb";
    MKPointAnnotation *LaVistaPoint =[[MKPointAnnotation alloc]init];
    LaVistaPoint.coordinate =LaVista;
    LaVistaPoint.title = @"LAFitness LaVista";
    MKPointAnnotation *GSURecPoint = [[MKPointAnnotation alloc]init];
    GSURecPoint.coordinate =GSURecCenter;
    GSURecPoint.title = @"GSU Recreation Center";
    MKPointAnnotation *CentralParkPoint = [[MKPointAnnotation alloc]init];
    CentralParkPoint.coordinate = CentralPark;
    CentralParkPoint.title = @"Central Park";
    
    
    
    
    
    
    
    NSString *mozleyParkPointGymName = mozleyParkPoint.title;
    NSString *perimeterPointGymName= perimeterPoint.title;
    NSString *brookhavenPointGymName = brookhavenPoint.title;
    NSString *AtlantaMosquePointGymName = AtlantaMosquePoint.title;
    NSString *BuckheadYMCAPointName = BuckheadYMCAPoint.title;
    NSString *BuckheadPointName =BuckheadPoint.title;
    NSString *AtlanticStationPointName =AtlanticStationPoint.title;
    NSString *CobbpointName = CobbPoint.title;
    NSString *LaVistaPointName=LaVistaPoint.title;
    NSString *GSURecCenterpointName=GSURecPoint.title;
    NSString *CentralParkPointName = CentralParkPoint.title;
    
    
    
    PFGeoPoint *mozleyParkGeoPoint = [PFGeoPoint geoPointWithLatitude:33.750969 longitude:-84.4351781];
    PFGeoPoint *brookhavenGeoPoint = [PFGeoPoint geoPointWithLatitude:33.872144 longitude:-84.33496];
    PFGeoPoint *perimeterGeoPoint = [PFGeoPoint geoPointWithLatitude:33.9241833 longitude:-84.3475771];
    PFGeoPoint *BuckheadGeoPoint = [PFGeoPoint geoPointWithLatitude:33.844438 longitude:-84.374171];
    PFGeoPoint *AtlantaMosqueGeoPoint= [PFGeoPoint geoPointWithLatitude:33.784678 longitude:-84.401004];
    PFGeoPoint *BuckheadYMCAGeoPoint=[PFGeoPoint geoPointWithLatitude:33.831421 longitude:-84.424819 ];
    PFGeoPoint *AtlanticStationGeoPoint =[PFGeoPoint geoPointWithLatitude:33.793815 longitude:-84.396206 ];
    PFGeoPoint *CobbGeoPoint = [PFGeoPoint geoPointWithLatitude:33.882146 longitude:-84.458447 ];
    PFGeoPoint *LavistaGeoPoint = [PFGeoPoint geoPointWithLatitude:33.842389 longitude:-84.246205 ];
    PFGeoPoint *GSURecGeoPoint = [PFGeoPoint geoPointWithLatitude:33.752502 longitude:-84.38464 ];
    PFGeoPoint *CentralParkGeoPoint = [PFGeoPoint geoPointWithLatitude:33.769497 longitude:-84.375808];
    
    
    
    
    
    float distance =0.1;
    
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if ([geoPoint distanceInMilesTo:mozleyParkGeoPoint] < distance) {
            
            userLocation=geoPoint;
            
            [[PFUser currentUser] setObject:mozleyParkPointGymName forKey:@"gymName"];
            [[PFUser currentUser] setObject:userLocation forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
        }
        
     else   if ([geoPoint distanceInMilesTo:brookhavenGeoPoint] < distance )
        {
            
            userLocation=geoPoint;
            
            [[PFUser currentUser] setObject:brookhavenPointGymName forKey:@"gymName"];
            [[PFUser currentUser] setObject:userLocation forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
        }
        
       else if ([geoPoint distanceInMilesTo:perimeterGeoPoint] < distance )
        {
            
            userLocation=geoPoint;
            
            [[PFUser currentUser] setObject:perimeterPointGymName forKey:@"gymName"];
            [[PFUser currentUser] setObject:userLocation forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
        }
        
      else  if ([geoPoint distanceInMilesTo:AtlantaMosqueGeoPoint] < distance )
        {
            
            userLocation=geoPoint;
            
            [[PFUser currentUser] setObject:AtlantaMosquePointGymName forKey:@"gymName"];
            [[PFUser currentUser] setObject:userLocation forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
            
            
        }
        
       else if ([geoPoint distanceInMilesTo:BuckheadYMCAGeoPoint] < distance )
        {
            
            userLocation=geoPoint;
            
            [[PFUser currentUser] setObject:BuckheadYMCAPointName forKey:@"gymName"];
            [[PFUser currentUser] setObject:userLocation forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
            
            
        }
        
       else if ([geoPoint distanceInMilesTo:BuckheadGeoPoint] < distance )
        {
            
            userLocation=geoPoint;
            
            [[PFUser currentUser] setObject:BuckheadPointName forKey:@"gymName"];
            [[PFUser currentUser] setObject:userLocation forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
            
            
        }
        
       else if ([geoPoint distanceInMilesTo:AtlanticStationGeoPoint] < distance )
        {
            
            userLocation=geoPoint;
            
            [[PFUser currentUser] setObject:AtlanticStationPointName forKey:@"gymName"];
            [[PFUser currentUser] setObject:userLocation forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
            
            
        }
       else if ([geoPoint distanceInMilesTo:CobbGeoPoint] < distance )
        {
            
            userLocation=geoPoint;
            
            NSLog(@"%@",userLocation);
            [[PFUser currentUser] setObject:CobbpointName forKey:@"gymName"];
            [[PFUser currentUser] setObject:userLocation forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
            
            
        }
      else  if ([geoPoint distanceInMilesTo:LavistaGeoPoint] < distance )
        {
            
            userLocation=geoPoint;
            
            [[PFUser currentUser] setObject:LaVistaPointName forKey:@"gymName"];
            [[PFUser currentUser] setObject:userLocation forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
            
            
        }
        
      else  if ([geoPoint distanceInMilesTo:GSURecGeoPoint] < distance )
        {
            
            userLocation=geoPoint;
            
            [[PFUser currentUser] setObject:GSURecCenterpointName forKey:@"gymName"];
            [[PFUser currentUser] setObject:userLocation forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
            
            
        }
        
     else   if ([geoPoint distanceInMilesTo:CentralParkGeoPoint] < distance )
        {
            
            userLocation=geoPoint;
            
            [[PFUser currentUser] setObject:CentralParkPointName forKey:@"gymName"];
            [[PFUser currentUser] setObject:userLocation forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
            
            
        }
        
        else  {
            
            userLocation = geoPoint;
            NSString *none = @"none";
            
            
            [[PFUser currentUser] setObject:none forKey:@"gymName"];
             [[PFUser currentUser] setObject:userLocation forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
            
            
        }
        
        
        
    }];
    
    
    
    
    
    
    
    
    
    NSMutableArray *points = [[NSMutableArray alloc]initWithObjects:brookhavenPoint,perimeterPoint,mozleyParkPoint,BuckheadYMCAPoint,BuckheadPoint,CobbPoint,AtlanticStationPoint,LaVistaPoint,GSURecPoint,CentralParkPoint, nil];
    
    [self.mapView addAnnotations:points];
    
    
    
    
    }

- (MKAnnotationView *) mapView: (MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation

{
    
    
    
    NSString *defaultID = @"myPin";
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:defaultID];
    
                                           
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = infoButton;
                                           
    annotationView.canShowCallout = YES;
    return  annotationView;
                                           
    
                                                           
}

-(void)mapView:(MKMapView * )mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control

{
    PFQuery *query = [PFUser query];
    [query whereKey:@"gymName" equalTo:view.annotation.title];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *currentUsers, NSError *error)
     
     {
         
         
        
         
         GymInfoDetailViewController *gymInfoDetailVC =[self.storyboard instantiateViewControllerWithIdentifier:@"GymInfoDetailViewController"];
        gymInfoDetailVC.gymUsers = currentUsers;
         NSString *gymLabelText = view.annotation.title;
         gymInfoDetailVC.gymLabelText = gymLabelText;
         
         [self.navigationController pushViewController:gymInfoDetailVC animated:YES];
         [gymInfoDetailVC.gymLabel setText:gymLabelText];
         
         
        
         
         
         
                 
         
         
     }];
   
   
        
    
    
    
    
    
        
   
    
    
    
    
    }





@end
