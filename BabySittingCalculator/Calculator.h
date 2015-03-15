//
//  Calculator.h
//  BabySittingCalculator
//
//  Created by Eric Maxwell on 3/14/15.
//  Copyright (c) 2015 Credible Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

- (double)calculateOneNightPayFromStartHour:(int)startHour toEndHour:(int)endHour;

@end