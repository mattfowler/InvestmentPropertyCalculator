//
//  PropertyInvestmentTest.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Mortgage.h"
#import "PropertyInvestment.h"
#import "propertyExpenses.h"

@interface PropertyInvestmentTest : SenTestCase {
    Mortgage *testMortgage;
    PropertyInvestment *propertyInvestment;
    PropertyExpenses *propertyExpenses;
}

-(void) testGetNetOperatingIncome;
-(void) testGetCapRate;
-(void) testGetCashOnCashReturn;
@end
