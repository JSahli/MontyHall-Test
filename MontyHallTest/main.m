//
//  main.m
//  MontyHallTest
//
//  Created by Jesse Sahli on 8/3/16.
//  Copyright © 2016 sahlitude. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Door.h"


BOOL playTheGame(BOOL contestantSwitches) {
    
    Door *doorOne = [[Door alloc]init];
    Door *doorTwo = [[Door alloc]init];
    Door *doorThree = [[Door alloc]init];
    
    //the contestant randomly chooses a door
    int contestantChoice = arc4random_uniform(24) % 3;
    switch (contestantChoice) {
        case 0:
            doorOne.isContestantChoice = YES;
            break;
        case 1:
            doorTwo.isContestantChoice = YES;
            break;
        case 2:
            doorThree.isContestantChoice = YES;
        default:
            break;
    }
    
    //randomly assigning a car to one of the three doors
    int randomChoice = arc4random_uniform(24) % 3;
    switch (randomChoice) {
        case 0:
            doorOne.hasCar = YES;
            break;
        case 1:
            doorTwo.hasCar = YES;
            break;
        case 2:
            doorThree.hasCar = YES;
        default:
            break;
    }
    
    //creating arrays to manipulate the doors randomly
    NSMutableArray *doors = [[NSMutableArray alloc]initWithObjects:doorOne, doorTwo, doorThree, nil];
    NSMutableArray *removabledoors = [[NSMutableArray alloc]init];
    NSMutableArray *finalTwoDoors = [[NSMutableArray alloc]init];
    
    for (Door *door in doors) {
        if (door.hasCar == NO && door.isContestantChoice == NO) {
            [removabledoors addObject:door];
        } else {
            [finalTwoDoors addObject:door];
        }
    }
    
    //randomly removing one of the wrong doors(IF THERE ARE MORE THAN ONE)
    int montysRandomChoice = arc4random_uniform(24) % 2;
    
    if (removabledoors.count > 1) {
        if (montysRandomChoice == 0) {
            [removabledoors removeObjectAtIndex:0];
            [finalTwoDoors addObjectsFromArray:removabledoors];
        } else {
            [removabledoors removeObjectAtIndex:1];
            [finalTwoDoors addObjectsFromArray:removabledoors];
        }
    } else {
        [removabledoors removeAllObjects];
    }
    
    
    BOOL contestantWon = NO;
    
    if (contestantSwitches == NO){
        for (Door* door in finalTwoDoors) {
            if (door.isContestantChoice == YES && door.hasCar == YES) {
//                NSLog(@"You won the car!");
                return YES;
                contestantWon = YES;
            }
        }
        if (contestantWon == NO) {
//            NSLog(@"Sorry... you won a goat!");
            return NO;
        }
    }
    
    if (contestantSwitches == YES){
        for (Door* door in finalTwoDoors) {
            if (door.isContestantChoice == NO && door.hasCar == YES) {
//                NSLog(@"You won the car!");
                return YES;
                contestantWon = YES;
            }
        }
        if (contestantWon == NO) {
//            NSLog(@"Sorry... you won a goat!");
            return NO;
        }
    }

    return NO;
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int winCounterNoSwitch;
        int lossCounterNoSwitch;
        
        for (int i = 0; i < 10000; i++) {
            BOOL result = playTheGame(NO);
            if (result == YES) {
                winCounterNoSwitch++;
            } else {
                lossCounterNoSwitch++;
            }
        }
        
        double winPercentage = ((double)winCounterNoSwitch/(winCounterNoSwitch + lossCounterNoSwitch)) * 100;
        NSLog(@"WHEN THE CONTESTANT DOES NOT SWITCH DOORS \nwins(cars) = %d \nlosses(goats) = %d \nWin Percentage = %.2f%% \n\n", winCounterNoSwitch, lossCounterNoSwitch, winPercentage);
        
        
        int winCounterSwitch;
        int lossCounterSwitch;
        
        for (int i = 0; i < 10000; i++) {
            BOOL result = playTheGame(YES);
            if (result == YES) {
                winCounterSwitch++;
            } else {
                lossCounterSwitch++;
            }
        }
         double winPercentageSwitch = ((double)winCounterSwitch/(winCounterSwitch + lossCounterSwitch)) * 100;
        NSLog(@"WHEN THE CONTESTANT DOES SWITCH DOORS \nwins(cars) = %d \nlosses(goats) = %d \nWin Percentage = %.2f%%", winCounterSwitch, lossCounterSwitch, winPercentageSwitch);

        
    }
    return 0;
}
