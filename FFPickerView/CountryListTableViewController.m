//
//  CountryListTableViewController.m
//  Pontifex
//
//  Created by Felix Ayala on 6/15/15.
//  Copyright (c) 2015 Opentech. All rights reserved.
//

#import "CountryListTableViewController.h"
#import "CountryModel.h"

static NSString *kCellIdentifier = @"CountryCell";

@interface CountryListTableViewController ()

@property (nonatomic, strong) NSMutableArray *countryList;
@property (nonatomic, strong) NSArray *filteredCountryListResults;

@property (nonatomic, strong) NSDictionary *sortedCountryList;
@property (nonatomic, strong) NSArray *countrySectionTitles;

@property (nonatomic, strong) NSDictionary *filteredSortedCountryList;
@property (nonatomic, strong) NSArray *filteredCountrySectionTitles;

@end

@implementation CountryListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.countryList = [NSMutableArray array];
	self.filteredCountryListResults = [NSArray array];
	
	[self customizeAppearance];
	[self loadDataFromJSON];
}

- (void)loadDataFromJSON {
	NSArray *countryList = [self dictionaryWithContentsOfJSONString:@"countries.json"];
	
	if ([countryList count] > 0) {
		
		for (NSDictionary *countryItem in countryList) {
			
			CountryModel *country = [[CountryModel alloc] init];
			country.countryID = [countryItem objectForKey:@"id"];
			country.name = [countryItem objectForKey:@"name"];
			
			[self.countryList addObject:country];
		}
		
		self.sortedCountryList = [self sortAlphabetically:[self.countryList copy]];
		self.countrySectionTitles = [[self.sortedCountryList allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
		
		[self.tableView reloadData];
	}
}

- (NSArray *)dictionaryWithContentsOfJSONString:(NSString*)fileLocation{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:[fileLocation pathExtension]];
	NSData* data = [NSData dataWithContentsOfFile:filePath];
	__autoreleasing NSError* error = nil;
	id result = [NSJSONSerialization JSONObjectWithData:data
												options:kNilOptions error:&error];
	// The result might be an NSArray as well!
	if (error != nil) return nil;
	return result;
}

- (void)customizeAppearance {
	
	[[self navigationItem] setTitle:@"Select a Country"];
	
	[self.tableView setTableFooterView:[UIView new]];
	[self.searchDisplayController.searchResultsTableView setTableFooterView:[UIView new]];
}

- (void) backButtonAction {
	[self.navigationController popViewControllerAnimated:YES];
}

- (NSDictionary *)sortAlphabetically:(NSArray *)list {
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	for (CountryModel *countryModel in list) {
		NSString *firstLetter = [[countryModel.name substringToIndex:1] uppercaseString];
		NSMutableArray *letterList = [dict objectForKey:firstLetter];
		if (!letterList) {
			letterList = [NSMutableArray array];
			[dict setObject:letterList forKey:firstLetter];
		}
		[letterList addObject:countryModel];
	}
	
	return [dict copy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		return [self.filteredCountrySectionTitles count];
	} else {
		return [self.countrySectionTitles count];
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	// Return the number of sections.
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		return [self.filteredCountrySectionTitles  objectAtIndex:section];
	} else {
		return [self.countrySectionTitles  objectAtIndex:section];
	}
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		NSString *sectionTitle = [self.filteredCountrySectionTitles objectAtIndex:section];
		NSArray *sectionCountryList = [self.filteredSortedCountryList objectForKey:sectionTitle];
		return [sectionCountryList count];
	} else {
		NSString *sectionTitle = [self.countrySectionTitles objectAtIndex:section];
		NSArray *sectionCountryList = [self.sortedCountryList objectForKey:sectionTitle];
		return [sectionCountryList count];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
	
	CountryModel *countryModel = nil;
	
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		NSString *sectionTitle = [self.filteredCountrySectionTitles objectAtIndex:indexPath.section];
		NSArray *sectionCountryList = [self.filteredSortedCountryList objectForKey:sectionTitle];
		countryModel = [sectionCountryList objectAtIndex:indexPath.row];
	} else {
		NSString *sectionTitle = [self.countrySectionTitles objectAtIndex:indexPath.section];
		NSArray *sectionCountryList = [self.sortedCountryList objectForKey:sectionTitle];
		countryModel = [sectionCountryList objectAtIndex:indexPath.row];
	}
	
	CountryModel *selectedCountry = (CountryModel *)self.selectedValue;
	
	cell.textLabel.text = countryModel.name;
	
	cell.accessoryType = [selectedCountry.countryID isEqualToString:countryModel.countryID] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
	return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		return self.filteredCountrySectionTitles;
	} else {
		return self.countrySectionTitles;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50.0;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	CountryModel *countryModel = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		NSString *sectionTitle = [self.filteredCountrySectionTitles objectAtIndex:indexPath.section];
		NSArray *sectionCountryList = [self.filteredSortedCountryList objectForKey:sectionTitle];
		countryModel = [sectionCountryList objectAtIndex:indexPath.row];
	} else {
		NSString *sectionTitle = [self.countrySectionTitles objectAtIndex:indexPath.section];
		NSArray *sectionCountryList = [self.sortedCountryList objectForKey:sectionTitle];
		countryModel = [sectionCountryList objectAtIndex:indexPath.row];
	}
 
	if (self.selectedIndex != NSNotFound && self.selectedRowSection != NSNotFound) {
		UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:
								 [NSIndexPath indexPathForRow:self.selectedIndex inSection:self.selectedRowSection]];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
 
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
 
	self.selectedIndex = indexPath.row;
	self.selectedRowSection = indexPath.section;
	self.selectedValue = countryModel;
	
	if ([self.parentViewController isKindOfClass:[UINavigationController class]]){
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark - UISearchBarController
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
	NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
	self.filteredCountryListResults = [self.countryList filteredArrayUsingPredicate:resultPredicate];
	
	self.filteredSortedCountryList = [self sortAlphabetically:[self.filteredCountryListResults copy]];
	self.filteredCountrySectionTitles = [[self.filteredSortedCountryList allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
	[self filterContentForSearchText:searchString
							   scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
									  objectAtIndex:[self.searchDisplayController.searchBar
													 selectedScopeButtonIndex]]];
	
	return YES;
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
	if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
		[self.tableView insertSubview:self.searchDisplayController.searchBar aboveSubview:self.tableView];
	}
}

@end
