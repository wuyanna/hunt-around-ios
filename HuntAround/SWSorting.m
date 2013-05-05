//
//  NSMutableArraySorting.m
//  SWGameLib
//
//
//  Copyright (c) 2010 Sangwoo Im
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  
//  Created by Sangwoo Im on 10/10/09.
//  Copyright 2009 Sangwoo Im. All rights reserved.
//

#import "SWSorting.h"
//#import "SWDebug.h"

@interface SWSortedObject : NSObject
<
           SWSortableObject
> {
@private
    NSUInteger objectID;
}
@property (nonatomic, assign) NSUInteger objectID;
@end
@implementation SWSortedObject 
@synthesize objectID;
@end

CFComparisonResult _compareObject(const void *val1, const void *val2, void *context) {
    
    id<SWSortableObject> operand1, operand2;
    
    operand1 = (id<SWSortableObject>)val1;
    operand2 = (id<SWSortableObject>)val2;
    
    if ([operand1 objectID] > [operand2 objectID]) {
        return NSOrderedDescending;
    } else if ([operand1 objectID] < [operand2 objectID]) {
        return NSOrderedAscending;
    }
    return NSOrderedSame;
}

#pragma mark -
@implementation NSMutableArray (SWObjectSorting)
- (void)insertSortedObject:(id<SWSortableObject>)object {
    CFIndex idx;
    
    idx = [self indexOfSortedObject:object];
    
    [self insertObject:object atIndex:idx];
}

- (void)removeSortedObject:(id<SWSortableObject>)object {
    if ([self count] == 0) {
        return;
    }
    CFIndex idx;
    id<SWSortableObject> foundObj;
    idx = [self indexOfSortedObject:object];
    
    if (idx < [self count] && idx >= 0) {
        foundObj = (id<SWSortableObject>)[self objectAtIndex:idx];
        
        if([foundObj objectID] == [object objectID]) {
            [self removeObjectAtIndex:idx];
        }
    }
}

- (void)setObjectID:(NSUInteger)tag ofSortedObject:(id<SWSortableObject>)object {
    id<SWSortableObject> foundObj;
    CFIndex  idx;
    
    idx = [self indexOfSortedObject:object];
    if (idx < [self count] && idx >= 0) {
        foundObj = [[self objectAtIndex:idx] retain];
        
        if([foundObj objectID] == [object objectID]) {
            [self removeObjectAtIndex:idx];
            [foundObj setObjectID:tag];
            [self insertSortedObject:foundObj];
            [foundObj release];
        } else {
            [foundObj release];
        }
    }
}
- (id<SWSortableObject>)objectWithObjectID:(NSUInteger)tag {
    if ([self count] == 0) {
        return nil;
    }
    
    CFIndex  idx;
    id<SWSortableObject> foundObj;
    
    foundObj = [[SWSortedObject alloc] init];
    [foundObj setObjectID:tag];
    
    idx      = [self indexOfSortedObject:foundObj];
    
    [foundObj release];
    foundObj = nil;
    
    if (idx < [self count] && idx >= 0) {
        foundObj = [self objectAtIndex:idx];
        if ([foundObj objectID] != tag) {
            foundObj = nil;
        }
    }
    
    return foundObj;
}

- (CFIndex)indexOfSortedObject:(id<SWSortableObject>)object {
    CFIndex  idx;
    if (object) {
        idx = CFArrayBSearchValues((CFArrayRef)self, CFRangeMake(0, [self count]),
                                   (void *)object, &_compareObject, NULL);
    } else {
        idx = NSNotFound;
    }

    return idx;
}

@end

#pragma mark -
@implementation CCArray (SWObjectSorting)
- (void)insertSortedObject:(id<SWSortableObject>)object {
    CFIndex idx;
    
    idx = [self indexOfSortedObject:object];
    
    [self insertObject:object atIndex:idx];
}

- (void)removeSortedObject:(id<SWSortableObject>)object {
    if ([self count] == 0) {
        return;
    }
    CFIndex idx;
    id<SWSortableObject> foundObj;
    idx = [self indexOfSortedObject:object];
    
    if (idx < [self count] && idx >= 0) {
        foundObj = (id<SWSortableObject>)[self objectAtIndex:idx];
        
        if([foundObj objectID] == [object objectID]) {
            [self removeObjectAtIndex:idx];
        }
    }
}

- (void)setObjectID:(NSUInteger)tag ofSortedObject:(id<SWSortableObject>)object {
    id<SWSortableObject> foundObj;
    CFIndex  idx;
    
    idx = [self indexOfSortedObject:object];
    if (idx < [self count] && idx >= 0) {
        foundObj = [[self objectAtIndex:idx] retain];
        
        if([foundObj objectID] == [object objectID]) {
            [self removeObjectAtIndex:idx];
            [foundObj setObjectID:tag];
            [self insertSortedObject:foundObj];
            [foundObj release];
        } else {
            [foundObj release];
        }
    }
}
- (id<SWSortableObject>)objectWithObjectID:(NSUInteger)tag {
    if ([self count] == 0) {
        return nil;
    }
    
    CFIndex  idx;
    id<SWSortableObject> foundObj;
    
    foundObj = [[SWSortedObject alloc] init];
    [foundObj setObjectID:tag];
    
    idx      = [self indexOfSortedObject:foundObj];
    
    [foundObj release];
    foundObj = nil;
    
    if (idx < [self count] && idx >= 0) {
        foundObj = [self objectAtIndex:idx];
        if ([foundObj objectID] != tag) {
            foundObj = nil;
        }
    }
    
    return foundObj;
}

- (CFIndex)indexOfSortedObject:(id<SWSortableObject>)object {
    CFIndex  idx;
    if (object) {
        idx = CFArrayBSearchValues((CFArrayRef)self, CFRangeMake(0, [self count]),
                                   (void *)object, &_compareObject, NULL);
    } else {
        idx = NSNotFound;
    }
    
    return idx;
}

@end