//
//  FFPickerTableViewController.m
//  FFPickerView
//
//  Created by Felix Ayala on 6/23/15.
//  Copyright (c) 2015 Pandorga. All rights reserved.
//

#import "FFPickerTableViewController.h"

@interface FFPickerTableViewController ()

@end

@implementation FFPickerTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.selectedIndex = self.selectedIndex ? self.selectedIndex : NSNotFound;
	self.selectedRowSection = self.selectedRowSection ? self.selectedRowSection : NSNotFound;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.actualValue = self.selectedValue;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if (self.selectedIndex != NSNotFound && self.selectedRowSection != NSNotFound) {
		[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:self.selectedRowSection] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	}
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
	
	if (![parent isEqual:self.parentViewController]) {
		if (self.selectedValue && ![self.selectedValue isEqual:self.actualValue] && self.delegate && [self.delegate respondsToSelector:@selector(dismissWithData:)]) {
			[self.delegate dismissWithData:self.selectedValue];
		}
	}
}

@end
