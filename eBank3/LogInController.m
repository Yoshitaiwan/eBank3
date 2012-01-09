//
//  LogInController.m
//  eBank4
//
//  Created by Yoshiyuki Matsuoka on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LogInController.h"

@implementation LogInController


- (void)dealloc {
    [keys_ release];
    [footerView release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 表示するデータを作成
    keys_ = [[NSArray alloc] initWithObjects:@"Log in using your email address and password",@"",  nil];
   
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0){
        return 2;
    }else 
        return 0;
  //  id key = [keys_ objectAtIndex:section];
  //  return [[dataSource_ objectForKey:key] count];
 //   return 2;
}

/*
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"basis-cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( nil == cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        [cell autorelease];
    }
    id key = [keys_ objectAtIndex:indexPath.section];
    NSString* text = [[dataSource_ objectForKey:key] objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    return cell;
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return [keys_ count];
  //  return 2;
}


- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    return [keys_ objectAtIndex:section];
}

// specify the height of your footer section
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //differ between your sections or if you
    //have only on section return a static value
    return 30;
}


-(void)logInClickedAction:(id)sender
{
    NSLog(@"clicked");
}

// custom view for footer. will be adjusted to default or specified footer height
// Notice: this will work only for one section within the table view
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if(footerView == nil) {
        //allocate the view if it doesn't exist yet
          footerView  = [[UIView alloc] init];
        
        //we would like to show a gloosy red button, so get the image first
        UIImage *buttonImage = [UIImage imageNamed:@"button_green.png"];
        UIImage *strechedImage = [buttonImage stretchableImageWithLeftCapWidth:8 topCapHeight:8];
       
        //create the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       [button setBackgroundImage:strechedImage forState:UIControlStateNormal];
        
        //the button should be as big as a table view cell  //
        [button setFrame:CGRectMake(10, 3, 300, 44)];
        
        //set title, font size and font color
        [button setTitle:@"Log In" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        //set action of the button
        [button addTarget:self action:@selector(logInClickedAction:)  forControlEvents:UIControlEventTouchDown];
        
        //add the button to the view
        [footerView addSubview:button];
    }
    
    //return the view for the footer
    return footerView;
}


#define kCellIdentifier @"identifier"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:kCellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if ([indexPath section] == 0) {
            UITextField *playerTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 10, 250, 30)];
            playerTextField.adjustsFontSizeToFitWidth = YES;
            playerTextField.textColor = [UIColor blackColor];
            if ([indexPath row] == 0) {
                playerTextField.placeholder = @"Email Address";
                playerTextField.keyboardType = UIKeyboardTypeEmailAddress;
                playerTextField.returnKeyType = UIReturnKeyDone;
                [playerTextField addTarget:self action:@selector(DoneToDimissKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
            }
            else if ([indexPath row] == 1) {
                playerTextField.placeholder = @"Password";
                playerTextField.keyboardType = UIKeyboardTypeDefault;
                playerTextField.returnKeyType = UIReturnKeyDone;
                playerTextField.secureTextEntry = YES;
                [playerTextField addTarget:self action:@selector(DoneToDimissKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
            }       
            playerTextField.backgroundColor = [UIColor whiteColor];
            playerTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
            playerTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
            playerTextField.textAlignment = UITextAlignmentLeft;
            playerTextField.tag = 0;
            //playerTextField.delegate = self;
            
             playerTextField.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
            [playerTextField setEnabled: YES];
            
            [cell addSubview:playerTextField];
            
            [playerTextField release];
        }
    }
    if ([indexPath section] == 1) { // Email & Password Section
    // Login button section
  //      cell.textLabel.text = @"Log in";
  //      cell.textLabel.textAlignment=UITextAlignmentCenter ;
  //      cell.textLabel.backgroundColor=  [UIColor greenColor];
//        cell.textLabel.shadowColor=  [UIColor greenColor];
//        cell.

    }
    return cell;    
}


- (void)DoneToDimissKeyboard:(id)sender
{
    [sender resignFirstResponder];
}



@end
