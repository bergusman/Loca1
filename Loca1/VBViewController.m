//
//  VBViewController.m
//  Loca1
//
//  Created by Vitaliy Berg on 5/10/13.
//  Copyright (c) 2013 Vitaliy Berg. All rights reserved.
//

#import "VBViewController.h"
#import <MapKit/MapKit.h>
#import "VBPointManager.h"

@interface VBViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation VBViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSavePoints:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:nil];
    
    NSArray *points = [[VBPointManager sharedManager] allPoints];
    for (VBPoint *point in points) {
        [self addPoint:point];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(55.767014, 37.588177);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(center, 6000, 6000);
    [self.mapView setRegion:region animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Core Data Notifications

- (void)didSavePoints:(NSNotification *)notification {
    NSArray *points =  notification.userInfo[NSInsertedObjectsKey];
    for (VBPoint *point in points) {
        [self addPoint:point];
    }
}

#pragma mark - Point Adding

- (void)addPoint:(VBPoint *)point {
    [self addAnnotationWithPoint:point];
    [self addOverlayWithPoint:point];
}

- (void)addAnnotationWithPoint:(VBPoint *)point {
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude);
    [self.mapView addAnnotation:pointAnnotation];
}

- (void)addOverlayWithPoint:(VBPoint *)point {
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(point.latitude, point.longitude);
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:center radius:point.accuracy];
    [self.mapView addOverlay:circle];
}

#pragma mark - MKMapViewDelegate

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:overlay];
    circleView.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.1];
    circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    circleView.lineWidth = 2;
    return circleView;
}

@end
