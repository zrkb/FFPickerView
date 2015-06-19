//
//  FFPickerViewController.m
//  FFPickerView
//
//  Created by Felix Ayala on 6/18/15.
//  Copyright (c) 2015 Pandorga. All rights reserved.
//

#import "FFPickerViewController.h"
#import "FFPickerOption.h"

@interface FFPickerViewController ()

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) id selectedValue;
@property (nonatomic, strong) id actualValue;

@end

@implementation FFPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.selectedIndex = self.selectedIndex ? self.selectedIndex : NSNotFound;
	
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.actualValue = self.selectedValue;
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
	
	
	if (![parent isEqual:self.parentViewController]) {
		if (self.selectedValue && ![self.selectedValue isEqual:self.actualValue] && self.delegate && [self.delegate respondsToSelector:@selector(dismissWithData:)]) {
			[self.delegate dismissWithData:self.selectedValue];
		}
	}
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	
//	if (cell == nil) {
//		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//	}
	
	if (self.selectedIndex == indexPath.row) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	id option = [self.options objectAtIndex:indexPath.row];
	
	NSString *displayText;
	
	if ([option isKindOfClass:[FFPickerOption class]]) {
		
		displayText = ((FFPickerOption *)option).displayText;
		
	} else if ([option isKindOfClass:[NSString class]]) {
		
		displayText = (NSString *)option;
		
	} else {
		
		displayText = [option description];
		
	}
	
	cell.textLabel.text = displayText;
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
 
	if (self.selectedIndex != NSNotFound) {
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:
								 [NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
 
	self.selectedIndex = indexPath.row;
 
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	id selectedOption = [self.options objectAtIndex:indexPath.row];
	self.selectedValue = selectedOption;
	
	if ([self.parentViewController isKindOfClass:[UINavigationController class]]){
		[self.navigationController popViewControllerAnimated:YES];
	}
}

@end