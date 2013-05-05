//
//  NSMutableArraySorting.h
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

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol SWSortableObject <NSObject>
-(NSUInteger)objectID;
-(void)setObjectID:(NSUInteger)objectID;
@end

/*!
 * This category supports sorting as you manipulate a mutable array.
 * 
 * If you mutate data without using one of the provided message in this
 * category, sorting will be disrupted. You will have to manually sort again
 * to make this extension to work properly.
 * 
 * it uses SWObject's objectID property as a key to sort.
 */
@interface NSMutableArray (SWObjectSorting)
/*!
 * Inserts a given object into array.
 * 
 * Inserts a given object into array with key and value that are used in
 * sorting. "value" must respond to message, compare:, which returns 
 * (NSComparisonResult). If it does not respond to the message, it is appended.
 * If the compare message does not result NSComparisonResult, sorting behavior
 * is not defined. It ignores duplicate entries and inserts next to it.
 *
 * @param object to insert
 */
- (void)insertSortedObject:(id<SWSortableObject>)object;

/*!
 * Removes an object in array.
 *
 * Removes an object with given key and value. If no object is found in array
 * with the key and value, no action is taken.
 *
 * @param value to remove
 */
- (void)removeSortedObject:(id<SWSortableObject>)object;
/*!
 * Sets a new value of the key for the given object.
 * 
 * In case where sorting value must be changed, this message must be sent to
 * keep consistency of being sorted. If it is changed externally, it must be
 * sorted completely again.
 *
 * @param value to set
 * @param object the object which has the value
 */
- (void)setObjectID:(NSUInteger)tag ofSortedObject:(id<SWSortableObject>)object;
/*!
 * Returns an object with given key and value.
 * 
 * Returns an object with given key and value. If no object is found,
 * it returns nil.
 *
 * @param value to locate object
 * @return object found or nil.
 */
- (id<SWSortableObject>)objectWithObjectID:(NSUInteger)tag;

/*!
 * Returns an index of the object with given key and value.
 *
 * Returns the index of an object with given key and value. 
 * If no object is found, it returns an index at which the given object value
 * would have been located. If object must be located at the end of array,
 * it returns the length of the array, which is out of bound.
 * 
 * @param value to locate object
 * @return index of an object found
 */
- (CFIndex)indexOfSortedObject:(id<SWSortableObject>)obj;
@end
/*!
 * This category supports sorting as you manipulate a mutable array.
 * 
 * If you mutate data without using one of the provided message in this
 * category, sorting will be disrupted. You will have to manually sort again
 * to make this extension to work properly.
 *
 * This class uses CCArray as base class.
 *
 * it uses SWObject's objectID property as a key to sort.
 */
@interface CCArray (SWObjectSorting)
/*!
 * Inserts a given object into array.
 * 
 * Inserts a given object into array with key and value that are used in
 * sorting. "value" must respond to message, compare:, which returns 
 * (NSComparisonResult). If it does not respond to the message, it is appended.
 * If the compare message does not result NSComparisonResult, sorting behavior
 * is not defined. It ignores duplicate entries and inserts next to it.
 *
 * @param object to insert
 */
- (void)insertSortedObject:(id<SWSortableObject>)object;

/*!
 * Removes an object in array.
 *
 * Removes an object with given key and value. If no object is found in array
 * with the key and value, no action is taken.
 *
 * @param value to remove
 */
- (void)removeSortedObject:(id<SWSortableObject>)object;
/*!
 * Sets a new value of the key for the given object.
 * 
 * In case where sorting value must be changed, this message must be sent to
 * keep consistency of being sorted. If it is changed externally, it must be
 * sorted completely again.
 *
 * @param value to set
 * @param object the object which has the value
 */
- (void)setObjectID:(NSUInteger)tag ofSortedObject:(id<SWSortableObject>)object;
/*!
 * Returns an object with given key and value.
 * 
 * Returns an object with given key and value. If no object is found,
 * it returns nil.
 *
 * @param value to locate object
 * @return object found or nil.
 */
- (id<SWSortableObject>)objectWithObjectID:(NSUInteger)tag;

/*!
 * Returns an index of the object with given key and value.
 *
 * Returns the index of an object with given key and value. 
 * If no object is found, it returns an index at which the given object value
 * would have been located. If object must be located at the end of array,
 * it returns the length of the array, which is out of bound.
 * 
 * @param value to locate object
 * @return index of an object found
 */
- (CFIndex)indexOfSortedObject:(id<SWSortableObject>)obj;
@end
