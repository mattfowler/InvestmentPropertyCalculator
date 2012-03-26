//
//  DollarValue.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Year = 0,
    Month = 1
} TimeInterval;

@interface DollarValueForInterval : NSObject {
    @private
    double value;
    TimeInterval interval;
}

@property (readonly) double dollarValue;

@property (readonly) TimeInterval timeInterval;

+(DollarValueForInterval*) createValue:(double) value forTimePeriod:(TimeInterval) interval;

-(id) initWithValue:(double)dollarValue andTimeInterval:(TimeInterval)timeInterval;

-(double) getValueForTimeInterval:(TimeInterval) interval;

@end
