//
//  MasterViewController.m
//  EveryDo
//
//  Created by Tenzin Phagdol on 2016-03-22.
//  Copyright © 2016 Jeffrey Ip. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ToDo.h"
#import "ToDoTableViewCell.h"
#import "ModalViewController.h"

@interface MasterViewController () <UITableViewDelegate, UITableViewDataSource, ModalDelegate>

@property (strong, nonatomic) IBOutlet UITableView *masterTableView;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //setup several ToDo objects
    ToDo *item1 = [[ToDo alloc] initWithTitle:@"Milk" description:@"buy milk from store" priorityNumber:@1 isCompletedIndicator:NO];
    ToDo *item2 = [[ToDo alloc] initWithTitle:@"Dog" description:@"walk the dog" priorityNumber:@2 isCompletedIndicator:NO];
    ToDo *item3 = [[ToDo alloc] initWithTitle:@"Taxes" description:@"do taxes" priorityNumber:@3 isCompletedIndicator:NO];
    ToDo *item4 = [[ToDo alloc] initWithTitle:@"Exercise" description:@"go to gym, exercise" priorityNumber:@4 isCompletedIndicator:YES];
    
    //crate array of ToDo objects
    self.objects = [@[item1, item2, item3, item4] mutableCopy];
    
    
    //establishing that this view controller is the delegate and datasource for UITableView
    self.masterTableView.delegate = self;
    self.masterTableView.dataSource = self;

    //add swipe functionality to the table view
    UISwipeGestureRecognizer *swipeRightCell = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeTableViewCell:)];
    swipeRightCell.direction = UISwipeGestureRecognizerDirectionRight;

    
    [self.masterTableView addGestureRecognizer:swipeRightCell];

    
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Delegate method for adding new To Do

- (void)addToDoItem:(ToDo *)item {
    [self.objects addObject:item];
    [self.masterTableView reloadData];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.masterTableView indexPathForSelectedRow];
    
        DetailViewController *detailVC = (DetailViewController *) segue.destinationViewController;
        
        //note that the objectAtIndex path are ToDo objects (i.e. of the ToDo class);
        ToDo *cellData = [self.objects objectAtIndex:indexPath.row];
        detailVC.detailItem = cellData;
        
    }
}

//transition from Master View Controller to Modal View Controller
//instantiate a ModalViewController object using storyboard identifier
//set the ModalViewController object's (modalVC) delegate to self, i.e. MasterViewController
//transition to modalVC
-(void) insertNewObject {
    ModalViewController *modalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
    
    modalVC.delegate = self;
    
    [self presentViewController:modalVC animated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ToDo *toDo = self.objects[indexPath.row];
    ToDoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.priorityLabel.text = [NSString stringWithFormat:@"%@", toDo.toDoPriorityNumber];
    cell.titleLabel.text = toDo.toDoTitle;
    cell.descriptionLabel.text = toDo.toDoDescription;
    
    //add strikethroughs to title and description text if completed
    if (toDo.toDoIsCompletedIndicator) {
        NSMutableAttributedString *titleStruckthrough = [[NSMutableAttributedString alloc] initWithString:toDo.toDoTitle];
        [titleStruckthrough addAttribute:NSStrikethroughStyleAttributeName
                                             value:@2
                                             range:NSMakeRange(0, [titleStruckthrough length])];
        cell.titleLabel.attributedText = titleStruckthrough;
        
        NSMutableAttributedString *descriptionStruckthrough = [[NSMutableAttributedString alloc] initWithString:toDo.toDoDescription];
        [descriptionStruckthrough addAttribute:NSStrikethroughStyleAttributeName
                                         value:@2
                                         range:NSMakeRange(0, [descriptionStruckthrough length])];
        cell.descriptionLabel.attributedText = descriptionStruckthrough;
    }
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

//method to cross off strikethrough completed items upon swiping left or right
-(void)didSwipeTableViewCell:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint swipeLocation = [recognizer locationInView:self.masterTableView];
        NSIndexPath *swipedIndexPath = [self.masterTableView indexPathForRowAtPoint:swipeLocation];
        // ...
        ToDo *todo = self.objects[swipedIndexPath.row];
        todo.toDoIsCompletedIndicator = YES;
        [self.masterTableView reloadData];
    }
    
}

@end
