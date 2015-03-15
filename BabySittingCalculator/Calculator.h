//
//  Calculator.h
//  BabySittingCalculator
//
//  Created by Eric Maxwell on 3/14/15.
//  Copyright (c) 2015 Credible Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

#define INVALID_START_HOUR_ERROR @"INVALID_START_HOUR"
#define INVALID_END_HOUR_ERROR @"INVALID_END_HOUR"

- (double)calculateOneNightPayFromStartHour:(int)startHour toEndHour:(int)endHour;

@end
