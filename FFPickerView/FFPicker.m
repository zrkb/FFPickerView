//
//  FFPicker.m
//  FFPickerView
//
//  Created by Felix Ayala on 6/18/15.
//  Copyright (c) 2015 Pandorga. All rights reserved.
//

#import "FFPicker.h"

@interface FFPicker () <FFPickerViewControllerDelegate>

@property (nonatomic, strong) FFPickerViewController *pickerViewController;
@property (nonatomic, strong) id selectedValue;

@end

@implementation FFPicker

- (instancetype)init {
	self = [super init];
	if (self) {
		[self baseInit];
	}
	return self;
}

- (instancetype)initWithOptions:(NSArray *)options {
	self = [super init];
	if (self) {
		self.options = options;
		
		[self baseInit];
	}
	return self;
}

- (void)baseInit {
	self.pickerViewController = [[FFPickerViewController alloc] initWithStyle:UITableViewStyleGrouped];
	self.pickerViewController.delegate = self;
}

- (void)show {
	
	if ([self.options count] == 0) return;
	
	UIViewController *controller = (UIViewController *)self.delegate;
	
	self.pickerViewController.options = self.options;
	
	if (controller.navigationController == nil || [controller isKindOfClass:[UINavigationController class]]){
		[controller presentViewController:self.pickerViewController animated:YES completion:nil];
	} else{
		[controller.navigationController pushViewController:self.pickerViewController animated:YES];
	}
}

- (void)dismissWithData:(id)data {
	if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectOption:)]) {
		[self.delegate didSelectOption:data];
	}
}

@end
