//
//  DollarValue.h
//  InvestmentPropertyCalculator
//
//  Created by MATTHEW FOWLER on 2/8/13.
//
//

#import <Foundation/Foundation.h>

@interface DollarValue : NSObject <NSCoding> {
    @private
    double value;
}

@property (readonly) double doubleValue;

+(DollarValue *) zeroDollars;

+(DollarValue *) createValue:(double) value;

-(NSString *) getCurrencyString;

-(NSString *) getDecimalString;

@end
