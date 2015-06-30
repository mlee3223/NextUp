//
//  GymRosterViewController.h
//  NextUp
//
//  Created by Michael Lee on 6/10/14.
//  Copyright (c) 2014 Michael Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface GymRosterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate ,UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSString *selectedUserId;

- (IBAction)addButton:(id)sender;
- (IBAction)minusButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *gymNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *todayDateLabel;

@property (strong,nonatomic) NSString *gymLabelText;

@property (strong, nonatomic) IBOutlet UILabel *selectedTimeLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *timePicker;
@property (strong,nonatomic) NSArray * gymTimes;
@property (strong,nonatomic)  NSArray *gymRoster;




@end
