//
//  DollarValue.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DollarValueForInterval.h"

@implementation DollarValueForInterval

@synthesize dollarValue = value;
@synthesize timeInterval = interval;

+(DollarValueForInterval*) createValue:(double) value forTimePeriod:(TimeInterval) interval {
    return [[[DollarValueForInterval alloc] initWithValue:value andTimeInterval:interval] autorelease];
}

- (id) initWithValue:(double)dollarValue andTimeInterval:(TimeInterval)timeInterval{
    self = [super init];
    if (self) {
        self->value = dollarValue;
        self->interval = timeInterval;
    }    
    return self;
}

-(double) getValueForTimeInterval:(TimeInterval) timeInterval {
    if(self->interval == timeInterval) {
        return value;
    } else {
        if (self->interval == Year) {
            return value / 12.0;
        } else {
            return value * 12.0;
        }
    }
}


@end
