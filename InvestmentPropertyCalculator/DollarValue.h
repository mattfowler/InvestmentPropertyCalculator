//
//  DollarValue.h
//  InvestmentPropertyCalculator
//
//  Created by MATTHEW FOWLER on 2/8/13.
//
//

#import <Foundation/Foundation.h>

@interface DollarValue : NSObject <NSCoding> {
    @protected
    double value;
}

@property (readonly) double doubleValue;

+(DollarValue *) zeroDollars;

+(DollarValue *) createValue:(double) value;

-(id) initWithValue:(double)dollarValue;

-(NSString *) getCurrencyString;

-(NSString *) getDecimalString;

@end
