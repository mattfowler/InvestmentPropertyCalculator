//
//  ProjectionsViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ProjectionsTableViewController.h"

@interface ProjectionsViewController : BaseViewController <UITextFieldDelegate> {
    @private
    ProjectionsTableViewController *projectionsTableViewController;
}

@property (nonatomic, retain) IBOutlet UITextField *rentIncreaseField;
@property (nonatomic, retain) IBOutlet UITextField *propertyAppreciationField;

@property (nonatomic, retain) IBOutlet UITableView *projectionsTableView;

- (IBAction)touchBackground:(id)sender;

@end
