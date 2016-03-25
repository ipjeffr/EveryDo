//
//  ToDo.m
//  EveryDo
//
//  Created by Tenzin Phagdol on 2016-03-22.
//  Copyright © 2016 Jeffrey Ip. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

-(instancetype)initWithTitle:(NSString *)title description:(NSString *)description priorityNumber:(NSNumber *)priorityNumber isCompletedIndicator:(BOOL)isCompletedIndicator {
    self = [super init];
    if (self) {
        _toDoTitle = title;
        _toDoDescription = description;
        _toDoPriorityNumber = priorityNumber;
        _toDoIsCompletedIndicator = isCompletedIndicator;
    } return self;
}

@end
