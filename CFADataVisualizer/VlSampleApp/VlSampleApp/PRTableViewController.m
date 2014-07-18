//
//  PRTableViewController.m
//  VlSampleApp
//
//  Created by Peter Reveles on 7/14/14.
//  Copyright (c) 2014 Peter Reveles. All rights reserved.
//

#import "PRTableViewController.h"
#import "PRDetailedPersonViewController.h"

@interface PRTableViewController ()
@end

@implementation PRTableViewController

#define PEOPLE_CELL_ID @"PeopleCellID"
#define DISPLAY_PERSON_DETAILS_SEGUE @"DisplayPersonDetailsSeque"
#define TEST_PHOTO_URL @"https://media.licdn.com/mpr/mpr/shrink_200_200/p/4/000/162/16c/26493e8.jpg"
#define Code_For_America_URL @"http://forever.codeforamerica.org/fellowship-2015-tech-interview/Violations-2012.csv"

#pragma mark - Accessor Methods
- (void)setPeople:(NSArray *)people{
    _people = people;
    [self.tableView reloadData];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
#warning TODO(Peter) This will be how we move to the next screen
    //[self prepareImageViewController:detail toDisplayPhoto:self.people[indexPath.row]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = PEOPLE_CELL_ID;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // customize cell
#warning TODO(Peter) Here is where you customize each cell
    //NSDictionary *photo = self.photos[indexPath.row];
#warning TODO This is currently hard coded, should be dynamic
    cell.textLabel.text = @"Angus Dunn";
    cell.detailTextLabel.text = @"Director of Mobie Engineering";
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareImageViewController:(PRDetailedPersonViewController *)detailedPersonVC toDisplayPerson:(PRPerson *)person{
    detailedPersonVC.personsPhotoUrl = [NSURL URLWithString:Code_For_America_URL];
    detailedPersonVC.person = person;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:DISPLAY_PERSON_DETAILS_SEGUE]) {
                if ([segue.destinationViewController isKindOfClass:[PRDetailedPersonViewController class]]) {
                    [self prepareImageViewController:segue.destinationViewController toDisplayPerson:(PRPerson *)self.people[indexPath.row]];
                }
            }
        }
    }
}

@end
