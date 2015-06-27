//
//  FFPickerTableViewController.h
//  FFPickerView
//
//  Created by Felix Ayala on 6/23/15.
//  Copyright (c) 2015 Pandorga. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FFPickerTableViewControllerDelegate <NSObject>

@required

- (void)dismissWithData:(id)data;

@end

@interface FFPickerTableViewController : UITableViewController

@property (nonatomic, assign) id <FFPickerTableViewControllerDelegate> delegate;

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) NSUInteger selectedRowSection;
@property (nonatomic, strong) id selectedValue;
@property (nonatomic, strong) id actualValue;

@end
