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

+(NSString *) getStringDollarValueFromDouble:(double)dollarValue;

-(id) initWithDollarValue:(DollarValue*)dollarValue andTimeInterval:(TimeInterval)timeInterval;

-(double) getValue;

-(DollarValue*) getDollarValue;

-(double) getValueForTimeInterval:(TimeInterval) interval;

-(double) getValueAfterYears:(int)years withAppreciationRate:(double)rate andTimeInterval:(TimeInterval) timeInterval;

@end
