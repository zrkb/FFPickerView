//
//  FFPickerViewController.h
//  FFPickerView
//
//  Created by Felix Ayala on 6/18/15.
//  Copyright (c) 2015 Pandorga. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FFPickerViewControllerDelegate <NSObject>

@optional

- (void)dismissWithData:(id)data;

@end

@interface FFPickerViewController : UITableViewController

@property (nonatomic, assign) id<FFPickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *options;

@end
