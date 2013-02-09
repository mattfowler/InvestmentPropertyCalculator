//
//  Mortgage.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DollarValue;

@interface Mortgage : NSObject <NSCoding>

@property int salesPrice;
@property double interestRate;
@property double downpaymentPercent;
@property int amoritizationYears;

- (id) initWithSalesPrice:(int)salesPrice downpayment:(double)downpayment interestRate:(double)interest years:(double) years;

- (DollarValue *) getMonthlyPayment;
- (double) getInitialPrincipal;
- (double) getDownpaymentAmount;
- (double) getTotalInterestPaid;
- (double) getInterestPaidInYear:(int)year;
- (double) getPrincipalPaidInYear:(int) year;

@end
