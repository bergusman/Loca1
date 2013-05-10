//
//  VBPointManager.m
//  Loca1
//
//  Created by Vitaliy Berg on 5/10/13.
//  Copyright (c) 2013 Vitaliy Berg. All rights reserved.
//

#import "VBPointManager.h"

@implementation VBPointManager

- (NSArray *)allPoints {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Point"
                                              inManagedObjectContext:self.managedObjectContext];
	[request setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        return nil;
    }
    
    return result;
}

- (VBPoint *)createPoint {
    VBPoint *point = [NSEntityDescription insertNewObjectForEntityForName:@"Point" inManagedObjectContext:self.managedObjectContext];
    if (!alarm) {
        return nil;
    }
    return point;
}

- (void)save {
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
    }
}

#pragma mark - Singleton

+ (VBPointManager *)sharedManager {
    static VBPointManager *_sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[VBPointManager alloc] init];
    });
    return _sharedManager;
}

@end
