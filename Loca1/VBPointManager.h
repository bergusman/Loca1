//
//  VBPointManager.h
//  Loca1
//
//  Created by Vitaliy Berg on 5/10/13.
//  Copyright (c) 2013 Vitaliy Berg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VBPoint.h"

@interface VBPointManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (NSArray *)allPoints;
- (VBPoint *)createPoint;
- (void)save;

+ (VBPointManager *)sharedManager;

@end
