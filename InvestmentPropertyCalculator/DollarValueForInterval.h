//
//  DollarValue.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DollarValue.h"

typedef enum {
    Year = 0,
    Month = 1
} TimeInterval;

@interface DollarValueForInterval : NSObject <NSCoding> {
    @private
    DollarValue* value;
    TimeInterval interval;
}

+(DollarValueForInterval*) createValue:(double) value forTimeInterval:(TimeInterval) interval;

-(double) getValue;

-(DollarValue *) getDollarValue;

-(DollarValue *) getDollarValueForTimeInterval:(TimeInterval) timeInterval;

-(DollarValue *) getValueAfterYears:(int)years withAppreciationRate:(double)rate andTimeInterval:(TimeInterval) timeInterval;

@end
