//
//  FFPicker.m
//  FFPickerView
//
//  Created by Felix Ayala on 6/18/15.
//  Copyright (c) 2015 Pandorga. All rights reserved.
//

#import "FFPicker.h"
#import "FFPickerViewController.h"

@interface FFPicker () <FFPickerTableViewControllerDelegate>

@property (nonatomic, strong) FFPickerViewController *pickerViewController;
@property (nonatomic, strong) id selectedValue;

@property (nonatomic, strong) FFPickerTableViewController *customPickerController;

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

- (void)showWithSegueIdentifier:(NSString *)storyboardID {
	UIViewController *controller = (UIViewController *)self.delegate;
	
	if (self.customPickerController == nil) {
		self.customPickerController = [controller.storyboard instantiateViewControllerWithIdentifier:storyboardID];
		self.customPickerController.delegate = self;
	}
	
	[controller.navigationController pushViewController:self.customPickerController animated:YES];
}

- (void)show {
	
	if ([self.options count] == 0) return;
	
	UIViewController *controller = (UIViewController *)self.delegate;
	
	if (self.navigationTitle) self.pickerViewController.title = self.navigationTitle;
	if (self.headerTitle) self.pickerViewController.headerTitle = self.headerTitle;
	
	self.pickerViewController.options = self.options;
	
	if (controller.navigationController == nil || [controller isKindOfClass:[UINavigationController class]]){
		[controller presentViewController:self.pickerViewController animated:YES completion:nil];
	} else{
		[controller.navigationController pushViewController:self.pickerViewController animated:YES];
	}
}

- (void)dismissWithData:(id)data {
	self.selectedOption = data;
	if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectOption:)]) {
		[self.delegate pickerView:self didSelectOption:data];
	}
}

@end
