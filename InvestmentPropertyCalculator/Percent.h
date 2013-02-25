//
//  Percent.h
//  InvestmentPropertyCalculator
//
//  Created by MATTHEW FOWLER on 2/24/13.
//
//

#import <Foundation/Foundation.h>

@interface Percent : NSObject <NSCoding> {
    @private
    double value;
}

@property (readonly) double doubleValue;

+(Percent *) create:(double) percentValue;

-(NSString *) getDisplayString;

@end
