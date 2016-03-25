//
//  ToDo.h
//  EveryDo
//
//  Created by Tenzin Phagdol on 2016-03-22.
//  Copyright © 2016 Jeffrey Ip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject

@property (nonatomic, strong) NSString *toDoTitle;
@property (nonatomic, strong) NSString *toDoDescription;
@property (nonatomic, strong) NSNumber *toDoPriorityNumber;
@property (nonatomic) BOOL toDoIsCompletedIndicator;

-(instancetype)initWithTitle:(NSString *)title description:(NSString *)description priorityNumber:(NSNumber *)priorityNumber isCompletedIndicator:(BOOL)isCompletedIndicator;

@end
