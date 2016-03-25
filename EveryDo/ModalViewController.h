//
//  ModalViewController.h
//  EveryDo
//
//  Created by Tenzin Phagdol on 2016-03-22.
//  Copyright © 2016 Jeffrey Ip. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToDo;
//declare the delegate protocol, and its delegate methods
@protocol ModalDelegate <NSObject>

-(void)addToDoItem:(ToDo *)item;

@end

@interface ModalViewController : UIViewController

//define a delegate property
@property (weak, nonatomic) id <ModalDelegate> delegate;

@end
