//
//  Enemy1.h
//  Super Defender
//
//  Created by Furkan on 10/14/13.
//  Copyright (c) 2013 RoFuPaNi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enemy.h"

@interface Enemy1 : Enemy
@property (nonatomic, assign) BOOL rotatesLeft;
@property (nonatomic, assign) int countdown;
@property (nonatomic, assign) int randomHeight;
@property (nonatomic, assign) BOOL movesLeft;
@end
