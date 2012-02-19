//
//  MortgageCalculator.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MortgageCalculator.h"

@implementation MortgageCalculator

+ (double) getMonthlyPaymentFromPrincipal:(int) principal interestRate:(double) interest years:(int) years {
    double monthlyInterest = interest / (12 * 100);
    int monthsOfLoan = years * 12;
    return principal * (monthlyInterest / (1 - pow(1 + monthlyInterest, -monthsOfLoan)));
}

@end
