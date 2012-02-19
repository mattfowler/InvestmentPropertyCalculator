//
//  MortgageCalculator.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MortgageCalculator : NSObject
    + (double) getMonthlyPaymentFromPrincipal:(int) principal interestRate:(double) interest years:(int) years;
@end
