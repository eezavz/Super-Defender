//
//  Object.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Object : NSObject

@property (nonatomic, assign) float centerX;
@property (nonatomic, assign) float centerY;

-(Object *)init: (float)x Y:(float)y;
-(void)update;

@end
