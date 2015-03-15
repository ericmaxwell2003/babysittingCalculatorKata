//
//  Calculator.m
//  BabySittingCalculator
//
//  Created by Eric Maxwell on 3/14/15.
//  Copyright (c) 2015 Credible Solutions, Inc. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

- (double)calculateOneNightPayFromStartHour:(int)startHour toEndHour:(int)endHour
{
    if(([self isHourAm:startHour] && startHour > 4) || ([self isHourPm:startHour] && startHour < 17)) {
        [NSException raise:INVALID_START_HOUR_ERROR format:@"startHour of %d is invalid, it cannot be before 5pm", startHour];
    } else if (([self isHourAm:endHour] && endHour > 4) || ([self isHourPm:endHour] && endHour < 17)) {
        [NSException raise:INVALID_END_HOUR_ERROR format:@"endHour of %d is invalid, it cannot be after 4am", endHour];
    }
    return 1.0;
}

- (BOOL)isHourAm:(int)hour
{
    return (hour - 12) < 0;
}

- (BOOL)isHourPm:(int)hour
{
    return ![self isHourAm:hour];
}

@end
