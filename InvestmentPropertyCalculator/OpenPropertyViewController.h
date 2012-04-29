//
//  OpenPropertyViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenPropertyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    @private
    
    UITableViewController *propertyTableViewController;
}

@property (nonatomic, retain) NSArray* propertyNames;
@property (nonatomic, retain) NSMutableArray* properties;
@property (nonatomic, retain) IBOutlet UITableView* propertyTableView;

-(IBAction)doneWithView:(id)sender;

@end
