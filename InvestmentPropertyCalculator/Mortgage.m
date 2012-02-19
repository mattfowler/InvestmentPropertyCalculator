//
//  Mortgage.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Mortgage.h"

@implementation Mortgage

@synthesize salesPrice;
@synthesize downpaymentPercent;
@synthesize interestRate;
@synthesize amoritizationYears;

- (id) initWithSalesPrice:(int)price downpayment:(double)downpayment interestRate:(double)interest years:(double) years {
    self = [super init];
    if (self) {
        salesPrice = price;
        downpaymentPercent = downpayment;
        interestRate = interest;
        amoritizationYears = years;
    }    
    return self;
}

- (double) getMonthlyPayment {
    double monthlyInterest = interestRate / (12 * 100);
    int monthsOfLoan = amoritizationYears * 12;
    return [self getInitialPrincipal] * (monthlyInterest / (1 - pow(1 + monthlyInterest, -monthsOfLoan)));
}

- (double) getInitialPrincipal {
    return salesPrice - [self getDownpaymentAmount];
}

- (double) getDownpaymentAmount {
    return salesPrice * (downpaymentPercent / 100);
}

@end
