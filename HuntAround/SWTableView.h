//
//  SWTableView.h
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
//
//  Created by Sangwoo Im on 6/3/10.
//  Copyright 2010 Sangwoo Im. All rights reserved.
//

#import "SWScrollView.h"

@class SWTableViewCell, SWTableView;
typedef enum {
    SWTableViewFillTopDown,
    SWTableViewFillBottomUp
} SWTableViewVerticalFillOrder;

/**
 * Sole purpose of this delegate is to single touch event in this version.
 */
@protocol SWTableViewDelegate
<
          SWScrollViewDelegate
>
/**
 * Delegate to respond touch event
 *
 * @param table table contains the given cell
 * @param cell  cell that is touched
 */
-(void)table:(SWTableView *)table cellTouched:(SWTableViewCell *)cell;
@end

/**
 * Data source that governs table backend data.
 */
@protocol SWTableViewDataSource
<
          NSObject
>
/**
 * cell height for a given table.
 *
 * @param table table to hold the instances of Class
 * @return cell size
 */
-(CGSize)cellSizeForTable:(SWTableView *)table;
/**
 * a cell instance at a given index
 *
 * @param idx index to search for a cell
 * @return cell found at idx
 */
-(SWTableViewCell *)table:(SWTableView *)table cellAtIndex:(NSUInteger)idx;
/**
 * Returns number of cells in a given table view.
 * 
 * @return number of cells
 */
-(NSUInteger)numberOfCellsInTableView:(SWTableView *)table;

@end


/**
 * UITableView counterpart for cocos2d for iphone.
 *
 * this is a very basic, minimal implementation to bring UITableView-like component into cocos2d world.
 * 
 */
@interface SWTableView 
:          SWScrollView
<
           SWScrollViewDelegate
>{
    /**
     * vertical direction of cell filling
     */
    SWTableViewVerticalFillOrder      vordering_;
@private
    /**
     * index set to query the indexes of the cells used.
     */
    NSMutableIndexSet *indices_;
    /**
     * cells that are currently in the table
     */
    NSMutableArray *cellsUsed_;
    /**
     * free list of cells
     */
    NSMutableArray *cellsFreed_;
    /**
     * weak link to the data source object
     */
    id<SWTableViewDataSource> dataSource_;
    /**
     * weak link to the delegate object
     */
    id<SWTableViewDelegate>   tDelegate_;
}
/**
 * data source
 */
@property (nonatomic, assign) id<SWTableViewDataSource> dataSource;
/**
 * delegate
 */
@property (nonatomic, assign) id<SWTableViewDelegate>   delegate;
/**
 * determines how cell is ordered and filled in the view.
 */
@property (nonatomic, assign, setter=setVerticalFillOrder:) SWTableViewVerticalFillOrder      verticalFillOrder;
/**
 * An intialized table view object
 *
 * @param dataSource data source
 * @param size view size
 * @return table view
 */
+(id)viewWithDataSource:(id<SWTableViewDataSource>)dataSource size:(CGSize)size;
/**
 * An initialized table view object
 *
 * @param dataSource data source;
 * @param size view size
 * @param container parent object for cells
 * @return table view
 */
+(id)viewWithDataSource:(id <SWTableViewDataSource>)dataSource size:(CGSize)size container:(CCNode *)container;
/**
 * Updates the content of the cell at a given index.
 *
 * @param idx index to find a cell
 */
-(void)updateCellAtIndex:(NSUInteger)idx;
/**
 * Inserts a new cell at a given index
 *
 * @param idx location to insert
 */
-(void)insertCellAtIndex:(NSUInteger)idx;
/**
 * Removes a cell at a given index
 *
 * @param idx index to find a cell
 */
-(void)removeCellAtIndex:(NSUInteger)idx;
/**
 * reloads data from data source.  the view will be refreshed.
 */
-(void)reloadData;
/**
 * Dequeues a free cell if available. nil if not.
 *
 * @return free cell
 */
-(SWTableViewCell *)dequeueCell;

/**
 * Returns an existing cell at a given index. Returns nil if a cell is nonexistent at the moment of query.
 *
 * @param idx index
 * @return a cell at a given index
 */
-(SWTableViewCell *)cellAtIndex:(NSUInteger)idx;
@end
