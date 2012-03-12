//
//  Mortgage.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mortgage : NSObject

@property int salesPrice;
@property double interestRate;
@property double downpaymentPercent;
@property int amoritizationYears;

- (id) initWithSalesPrice:(int)salesPrice downpayment:(double)downpayment interestRate:(double)interest years:(double) years;

- (double) getMonthlyPayment;
- (double) getInitialPrincipal;
- (double) getDownpaymentAmount;
- (double) getTotalInterestPaid;

@end
