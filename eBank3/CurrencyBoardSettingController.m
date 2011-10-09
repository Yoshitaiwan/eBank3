//
//  CurrencyBoardSettingController.m
//  eBank3
//
//  Created by Yoshiyuki Matsuoka on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrencyBoardSettingController.h"


#define kSliderHeight			7.0
#define kProgressIndicatorSize	40.0
#define kUIProgressBarWidth		160.0
#define kUIProgressBarHeight	24.0

#define kViewTag				1		// for tagging our embedded controls for removal at cell recycle time

static NSString *kSectionTitleKey = @"sectionTitleKey";
static NSString *kLabelKey = @"labelKey";
static NSString *kSourceKey = @"sourceKey";
static NSString *kViewKey = @"viewKey";

#pragma mark -

@implementation CurrencyBoardSettingController

@synthesize dataSourceArray;

- (void)dealloc
{	
 	[switchCtl release];
    switchCtl = nil;
    
	[sliderCtl release];
	sliderCtl=nil;
	[dataSourceArray release];
	
	[super dealloc];
}

- (void)viewDidLoad
{	
    [super viewDidLoad];
	self.title = NSLocalizedString(@"Settings", @"");
    
	self.dataSourceArray = [NSArray arrayWithObjects:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"Trade Enabled", kSectionTitleKey,
                             @" ", kLabelKey,
                             @"ControlsViewController.m:\r-(UISwitch *)switchCtl", kSourceKey,
                             self.switchCtl, kViewKey,
							 nil],

							[NSDictionary dictionaryWithObjectsAndKeys:
                             @"Volume Allowed", kSectionTitleKey,
                             @"100 per a day", kLabelKey,
                             @"ControlsViewController.m:\r-(UISlider *)sliderCtl", kSourceKey,
                             self.sliderCtl, kViewKey,
							 nil],
							
                            
							nil];
}

// called after the view controller's view is released and set to nil.
// For example, a memory warning which causes the view to be purged. Not invoked as a result of -dealloc.
// So release any properties that are loaded in viewDidLoad or can be recreated lazily.
//
- (void)viewDidUnload 
{
    [super viewDidUnload];
	
	// release the controls and set them nil in case they were ever created
	// note: we can't use "self.xxx = nil" since they are read only properties
	//
    [sliderCtl release];
    sliderCtl = nil;
	
	self.dataSourceArray = nil;	// this will release and set to nil
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.dataSourceArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[self.dataSourceArray objectAtIndex: section] valueForKey:kSectionTitleKey];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

// to determine specific row height for each cell, override this.
// In this example, each row is determined by its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return ([indexPath row] == 0) ? 50.0 : 38.0;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
    
	if ([indexPath row] == 0)
	{
		static NSString *kDisplayCell_ID = @"DisplayCellID";
		cell = [self.tableView dequeueReusableCellWithIdentifier:kDisplayCell_ID];
        if (cell == nil)
        {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDisplayCell_ID] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		else
		{
			// the cell is being recycled, remove old embedded controls
			UIView *viewToRemove = nil;
			viewToRemove = [cell.contentView viewWithTag:kViewTag];
			if (viewToRemove)
				[viewToRemove removeFromSuperview];
		}
		
		cell.textLabel.text = [[self.dataSourceArray objectAtIndex: indexPath.section] valueForKey:kLabelKey];
		
		UIControl *control = [[self.dataSourceArray objectAtIndex: indexPath.section] valueForKey:kViewKey];
		[cell.contentView addSubview:control];
	}
	else
	{
		static NSString *kSourceCellID = @"SourceCellID";
		cell = [self.tableView dequeueReusableCellWithIdentifier:kSourceCellID];
        if (cell == nil)
        {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSourceCellID] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			cell.textLabel.opaque = NO;
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.textColor = [UIColor grayColor];
			cell.textLabel.numberOfLines = 2;
			cell.textLabel.highlightedTextColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];	
        }
		
		cell.textLabel.text = [[self.dataSourceArray objectAtIndex: indexPath.section] valueForKey:kSourceKey];
	}
    
	return cell;
}

- (void)switchAction:(id)sender
{
	// NSLog(@"switchAction: value = %d", [sender isOn]);
}



#pragma mark -
#pragma mark Lazy creation of controls

- (UISwitch *)switchCtl
{
    if (switchCtl == nil) 
    {
        CGRect frame = CGRectMake(198.0, 12.0, 94.0, 27.0);
        switchCtl = [[UISwitch alloc] initWithFrame:frame];
        [switchCtl addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        // in case the parent view draws with a custom color or gradient, use a transparent color
        switchCtl.backgroundColor = [UIColor clearColor];
		
		[switchCtl setAccessibilityLabel:NSLocalizedString(@"StandardSwitch", @"")];
		
		switchCtl.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
    }
    return switchCtl;
}

- (void)sliderAction:(id)sender
{ }

- (UISlider *)sliderCtl
{
    if (sliderCtl == nil) 
    {
        CGRect frame = CGRectMake(174.0, 12.0, 120.0, kSliderHeight);
        sliderCtl = [[UISlider alloc] initWithFrame:frame];
        [sliderCtl addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        
        // in case the parent view draws with a custom color or gradient, use a transparent color
        sliderCtl.backgroundColor = [UIColor clearColor];
        
        sliderCtl.minimumValue = 0.0;
        sliderCtl.maximumValue = 100.0;
        sliderCtl.continuous = YES;
        sliderCtl.value = 50.0;
        
		// Add an accessibility label that describes the slider.
		[sliderCtl setAccessibilityLabel:NSLocalizedString(@"StandardSlider", @"")];
		
		sliderCtl.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
    }
    return sliderCtl;
}
@end
