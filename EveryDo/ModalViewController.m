//
//  ModalViewController.m
//  EveryDo
//
//  Created by Tenzin Phagdol on 2016-03-22.
//  Copyright © 2016 Jeffrey Ip. All rights reserved.
//

#import "ModalViewController.h"
#import "ToDo.h"

@interface ModalViewController ()

@property (weak, nonatomic) IBOutlet UITextField *priorityInputTextField;
@property (weak, nonatomic) IBOutlet UITextField *titleInputTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionInputTextView;
@property (strong, nonatomic) ToDo *willAddToDo;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (IBAction)addToDoItemButton:(id)sender {

    NSString *priorityText = self.priorityInputTextField.text;
    NSString *titleText = self.titleInputTextField.text;
    NSString *descriptionText = self.descriptionInputTextView.text;
    
    NSNumberFormatter *n = [[NSNumberFormatter alloc] init];
    n.numberStyle = NSNumberFormatterNoStyle;
    NSNumber *priorityNumber = [n numberFromString:priorityText];
    
    ToDo *newToDoItem = [[ToDo alloc] initWithTitle:titleText description:descriptionText priorityNumber:priorityNumber isCompletedIndicator:NO];
    self.willAddToDo = newToDoItem;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addToDoItem:)]){
        [self.delegate addToDoItem:newToDoItem];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
