//
//  ViewController.m
//  FFPickerView
//
//  Created by Felix Ayala on 6/18/15.
//  Copyright (c) 2015 Pandorga. All rights reserved.
//

#import "ViewController.h"
#import "FFPicker.h"

@interface ViewController () <FFPickerDelegate>

@property (nonatomic, strong) FFPicker *picker;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.picker = [[FFPicker alloc] initWithOptions:[NSArray arrayWithObjects:
													 [FFPickerOption optionWithTitle:@"Foo" value:@"1"],
													 [FFPickerOption optionWithTitle:@"Bar" value:@"2"],
													 [FFPickerOption optionWithTitle:@"barz" value:@"3"], nil]];
	self.picker.delegate = self;
}

- (IBAction)showPicker:(id)sender {
	[self.picker show];
}

- (void)didSelectOption:(id)option {
	NSLog(@"Option: %@", option);
}

@end
