////
////  ToolUtil.m
////  Try_HitBrick
////
////  Created by irons on 2015/5/22.
////  Copyright (c) 2015年 irons. All rights reserved.
////
//
#import "ToolUtil.h"
#import "MyScene.h"
//#import "BallUtil.h"
//#import "MyScene.h"
#import "BrickUtil.h"
#import "BitmapUtil.h"

enum ToolType {
    BallSpeedUp, BallSpeedDown, StickLongUp, StickLongDown, BallCountUpToThree, LifeUp, BallReset, StickLongMax, BallRadiusUp, BallRadiusDown, BlackHole, BallLevelUpTwice, BallLevelDownOnce
};
//
@implementation ToolUtil{
    MyScene* ballView;
    float saveStickLong;
    SKTexture* toolBitmap;
    TimerThread *timerThread;
    enum ToolType whichToolType;
    int toolObjLeft, toolObjTop;
    
    CGRect toolRect;
}
//@end
//

//const int TYPE_NUM = 13;


//
//const static int TOOL_DOWN_SPEED = 1;

//int saveStickLong;
//int saveBallRadius;
//int saveBallSpeedX;
//int saveBallSpeedY;

//


+(instancetype)initWithBallView:(MyScene*) mballView BrickUtil:(BrickUtil*) brickUtil{
    ToolUtil* tool = [ToolUtil spriteNodeWithTexture:nil];
    if (tool) {
        
        tool->ballView = mballView;
        [tool setToolObjectXY:brickUtil.left BrickTop:brickUtil.top BrickRight:brickUtil.right BrickBottom:brickUtil.bottom];
        [tool setRandomEffectType ];
        [tool setToolBitmap];
        tool.isStartDownTool = false;
        
        //        tool.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:tool.frame.size];
        //        tool.physicsBody.categoryBitMask = toolCategory;
        //        tool.physicsBody.dynamic = NO;
    }
    return tool;
}

//
////public ToolUtil(BallView ballView, BrickUtil* brickUtil) {
////    this.ballView = ballView;
////    setToolObjectXY(brickUtil.left, brickUtil.top, brickUtil.right,
////                    brickUtil.bottom);
////    setRandomEffectType();
////    setToolBitmap();
////}
//
-(void) setRandomEffectType {
    //    int whichType = arc4random_uniform(TYPE_NUM);
    //    EffectType effectTypes[7];
    //
    //    effectTypes[0] = Once;
    //    effectTypes[1] = Twice;
    //    effectTypes[2] = Three;
    //    effectTypes[3] = Iron;
    //    effectTypes[4] = Time;
    //    effectTypes[5] = Tool;
    //    effectTypes[6] = BallLevelUP;
    
    int whichType = arc4random_uniform(13);
    
    enum ToolType toolTypes[13];
    
    //    EffectType *effectTypes = malloc(sizeof(EffectType)*6);
    
    toolTypes[0] = BallSpeedUp;
    toolTypes[1] = BallSpeedDown;
    toolTypes[2] = StickLongUp;
    toolTypes[3] = StickLongDown;
    toolTypes[4] = BallCountUpToThree;
    toolTypes[5] = LifeUp;
    toolTypes[6] = BallReset;
    toolTypes[7] = StickLongMax;
    toolTypes[8] = BallRadiusUp;
    toolTypes[9] = BallRadiusDown;
    toolTypes[10] = BlackHole;
    toolTypes[11] = BallLevelUpTwice;
    toolTypes[12] = BallLevelDownOnce;
    whichToolType = toolTypes[whichType];
    
    //		if(whichType%2==0)
    //			whichToolType = ToolType.BallCountUpToThree;
    //		else
    //			whichToolType = ToolType.BallReset;
    
    if(whichToolType == BlackHole){
        //        int randomBlackHoleMinY = [ballView getBricksAreaBottom ];
        //        int randomBlackHoleMaxY = (int) (ballView.heightScreen - ballView.THICK_OF_STICK - toolRect.height());
        //        int randomBlackHoleY = random.nextInt(randomBlackHoleMaxY - randomBlackHoleMinY +1) + randomBlackHoleMinY;
        //        toolObjTop = randomBlackHoleY;
        //        int randomBlackHoleX = random.nextInt((int) (ballView.widthScreen - toolRect.width()));
        //        toolRect.set(randomBlackHoleX, toolObjTop, randomBlackHoleX + toolRect.width(), toolObjTop + toolRect.height());
    }
}

-(void) setToolObjectXY:(int) BrickLeft BrickTop:(int) BrickTop BrickRight:(int) BrickRight BrickBottom:(int) BrickBottom {
    int height = (BrickTop - BrickBottom)*3/4;
    int width = height;
    toolObjTop = BrickTop;
    toolObjLeft = (BrickLeft + BrickRight - width) / 2;
    //    toolRect.set(toolObjLeft, toolObjTop, toolObjLeft + width, toolObjTop
    //                 + height);
    toolRect = CGRectMake(toolObjLeft, toolObjTop, width, height);
    self.position = CGPointMake(toolObjLeft, toolObjTop);
    self.size = CGSizeMake(width, height);
}

-(void) setToolBitmap{
    BitmapUtil * bitmapUtil = [BitmapUtil sharedInstance];
    switch (whichToolType) {
        case BallSpeedUp:
            toolBitmap = bitmapUtil.tool_BallSpeedUp_bmp;
            break;
        case BallSpeedDown:
            toolBitmap = bitmapUtil.tool_BallSpeedDown_bmp;
            break;
        case StickLongUp:
            toolBitmap = bitmapUtil.tool_StickLongUp_bmp;
            break;
        case StickLongDown:
            toolBitmap = bitmapUtil.tool_StickLongDown_bmp;
            break;
        case BallCountUpToThree:
            toolBitmap = bitmapUtil.tool_BallCountUpToThree_bmp;
            break;
        case LifeUp:
            toolBitmap = bitmapUtil.tool_LifeUp_bmp;
            break;
        case BallReset:
            toolBitmap = bitmapUtil.tool_BallReset_bmp;
            break;
        case StickLongMax:
            toolBitmap = bitmapUtil.tool_StickLongMax_bmp;
            break;
        case BallRadiusUp:
            toolBitmap = bitmapUtil.tool_BallRadiusUp_bmp;
            break;
        case BallRadiusDown:
            toolBitmap = bitmapUtil.tool_BallRadiusDown_bmp;
            break;
        case BlackHole:
            toolBitmap = bitmapUtil.tool_BlackHole_bmp;
            break;
        case BallLevelUpTwice:
            toolBitmap = bitmapUtil.tool_BallLevelUpTwice_bmp;
            break;
        case BallLevelDownOnce:
            toolBitmap = bitmapUtil.tool_BallLevelDownOnce_bmp;
            break;
    }
    
    self.texture = toolBitmap;
//    SKTexture *texture = toolBitmap;
//    SKAction *action = [SKAction setTexture:toolBitmap];
//    SKAction *action = [SKAction animateWithTextures:@[toolBitmap] timePerFrame:0.1];
//
//    [self runAction:action];
}

//-(void) doTool {
//    switch (whichToolType) {
//		case BallSpeedUp:
//			ballView.setBallSpeed(ballView.getBallSpeedX() * 2,
//                                  ballView.getBallSpeedY() * 2);
//			break;
//		case BallSpeedDown:
//			ballView.setBallSpeed(ballView.getBallSpeedX() / 2,
//                                  ballView.getBallSpeedY() / 2);
//			break;
//		case StickLongUp:
//			ballView.setStickLong((int) (ballView.getStickLong() * 1.5));
//			break;
//		case StickLongDown:
//			ballView.setStickLong((int) (ballView.getStickLong() * 0.5));
//			break;
//		case BallCountUpToThree:
//			ballView.setBallCount(3);
//			break;
//		case BallRadiusUp:
//			ballView.setBallRadius((int) (ballView.getBallRadius() * 1.5));
//			break;
//		case BallRadiusDown:
//			ballView.setBallRadius((int) (ballView.getBallRadius() * 0.5));
//			break;
//    }
//}

-(void) doTool:(NSMutableArray*) ballUtils ball:(BallUtil*) ball showToolEffectTime:(NSMutableArray*)showToolEffectTime {
    switch (whichToolType) {
        case BallSpeedUp:
            // ball.setSpeedX(ball.getSpeedX() * 2);
            // ball.setSpeedY(ball.getSpeedY() * 2);
            self.ball = ball;
            //			[ballView setBallSpeed(ballView.getBallSpeedX() * 2,
            //                                  ballView.getBallSpeedY() * 2)];
            [ball setSpeedX:[ball getSpeedX]*2];
            [ball setSpeedY:[ball getSpeedY]*2];
            
            //            [ball.physicsBody applyForce:CGVectorMake([ball getSpeedX]*2, [ball getSpeedY]*2)];
            [ball.physicsBody setVelocity:CGVectorMake(ball.physicsBody.velocity.dx*2, ball.physicsBody.velocity.dy*2)];
            
            timerThread = [TimerThread initWithTime:10];
            [timerThread start];
            [showToolEffectTime addObject:self];
            break;
        case BallSpeedDown:
            // ball.setSpeedX(ball.getSpeedX() / 2);
            // ball.setSpeedY(ball.getSpeedY() / 2);
            self.ball = ball;
            //			ballView.setBallSpeed(ballView.getBallSpeedX() / 2,
            //                                  ballView.getBallSpeedY() / 2);
            [ball setSpeedX:[ball getSpeedX]/2];
            [ball setSpeedY:[ball getSpeedY]/2];
            
            //            [ball.physicsBody applyForce:CGVectorMake([ball getSpeedX]/2, [ball getSpeedY]/2)];
            [ball.physicsBody setVelocity:CGVectorMake(ball.physicsBody.velocity.dx/2, ball.physicsBody.velocity.dy/2)];
            
            //			timerThread = new TimerThread(10);
            timerThread = [TimerThread initWithTime:10];
            [timerThread start];
            [showToolEffectTime addObject:self];
            break;
        case StickLongUp:
            self.ball = ball;
            [ballView setStickLong:[ballView getStickLong]*1.5];
            timerThread = [TimerThread initWithTime:10];
            [timerThread start];
            [showToolEffectTime addObject:self];
            break;
        case StickLongDown:
            self.ball = ball;
            [ballView setStickLong:[ballView getStickLong]*0.5];
            timerThread = [TimerThread initWithTime:10];
            [timerThread start];
            [showToolEffectTime addObject:self];
            break;
        case BallCountUpToThree:
            // ballView.setBallCount(3);
            for (int i = ballUtils.count; i < 3; i++) {
                //				float angle = ball.getAngle();
                //
                ////				Random random = new Random();
                //				int randomAngle = arc4random_uniform(360);
                //				if (randomAngle < 20 || randomAngle > 340
                //                    || (randomAngle > 160 && randomAngle < 200)) {
                //					randomAngle = 90;
                //				}
                //				if (randomAngle > angle - 5 && randomAngle < angle + 5) {
                //					randomAngle += 10;
                //				}
                //
                //				float newSpeedX = ballView.getSpeedX((float) randomAngle);
                //				float newSpeedY = ballView.getSpeedY((float) randomAngle);
                
                BallUtil* newBall = [BallUtil initBallUtil:0 speedX:0 speedY:0 imageX:0 imageY:0 fAngle:0 RADIUS:10];
                [ballUtils addObject:newBall];
                
                newBall.name = ball.name;
                //                newBall.position = CGPointMake(self.frame.size.width/3, self.frame.size.height/3);
                newBall.position = ball.position;
                //        ball.size = CGSizeMake(50, 50);
                [ballView addChild:newBall];
                
                // 2
                newBall.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:newBall.frame.size.width/2];
                // 3
                newBall.physicsBody.friction = 0.0f;
                // 4
                newBall.physicsBody.restitution = 1.0f;
                // 5
                newBall.physicsBody.linearDamping = 0.0f;
                // 6
                newBall.physicsBody.allowsRotation = NO;
                
                [newBall.physicsBody applyImpulse:CGVectorMake(10.0f, -10.0f)];
                newBall.physicsBody.categoryBitMask = ball.physicsBody.categoryBitMask;
                newBall.physicsBody.contactTestBitMask = ball.physicsBody.contactTestBitMask;
            }
            break;
        case LifeUp:
            [ballView setBallLife:[ballView getBallLife] + 1];
            break;
        case BallReset:
            [ballView resetBall];
            //            self.ball = ball;
            //            int ballLevel = ([ball getBallLevel]>1) ? -1:([ball getBallLevel]+1);
            //            [ball setBallLevel:ballLevel];
            break;
        case StickLongMax:
            self.ball = ball;
            saveStickLong = [ballView getStickLong ];
            [ballView setStickLong:ballView.size.width];
            
            // time.start();
            
            timerThread = [TimerThread initWithTime:10];
            [timerThread start];
            [showToolEffectTime addObject:self];
            break;
        case BallRadiusUp:
            self.ball = ball;
            //			ball.setRadius((int) (ball.getRadius() * 1.5));
            ball.xScale = 1.5;
            ball.yScale = 1.5;
            timerThread = [TimerThread initWithTime:10];
            [timerThread start];
            [showToolEffectTime addObject:self];
            break;
        case BallRadiusDown:
            self.ball = ball;
            //			ball.setRadius((int) (ball.getRadius() * 0.5));
            ball.xScale = 0.5;
            ball.yScale = 0.5;
            timerThread = [TimerThread initWithTime:10];
            [timerThread start];
            [showToolEffectTime addObject:self];
            break;
        case BlackHole:
            self.ball = ball;
            [ball setBallLevel:-5];
            break;
        case BallLevelUpTwice:{
            self.ball = ball;
            //            NSString *a = nil;
            //            NSString* a; = 1<2 ? 0:1;
            int ballLevel = ([ball getBallLevel]>0) ? -1:([ball getBallLevel]+2);
            [ball setBallLevel:ballLevel];
            break;
        }case BallLevelDownOnce:
            self.ball = ball;
            [ball setBallLevel:[ball getBallLevel]-1];
            break;
    }
}

-(void) doToolFinish {
    if (self.ball != nil) {
        switch (whichToolType) {
            case BallSpeedUp:
                //				ball.setSpeedX(ball.getSpeedX() / 2);
                //				ball.setSpeedY(ball.getSpeedY() / 2);
                [self.ball setSpeedX:[self.ball getSpeedX]/2];
                [self.ball setSpeedY:[self.ball getSpeedY]/2];
                
                //                [self.ball.physicsBody applyForce:CGVectorMake([self.ball getSpeedX]/2, [self.ball getSpeedY]/2)];
                [self.ball.physicsBody setVelocity:CGVectorMake(self.ball.physicsBody.velocity.dx/2, self.ball.physicsBody.velocity.dy/2)];
                break;
            case BallSpeedDown:
                [self.ball setSpeedX:[self.ball getSpeedX]*2];
                [self.ball setSpeedY:[self.ball getSpeedY]*2];
                
                //                [self.ball.physicsBody applyForce:CGVectorMake([self.ball getSpeedX]*2, [self.ball getSpeedY]*2)];
                [self.ball.physicsBody setVelocity:CGVectorMake(self.ball.physicsBody.velocity.dx*2, self.ball.physicsBody.velocity.dy*2)];
                break;
            case StickLongUp:
                [ballView setStickLong:(int) ([ballView getStickLong] * 0.67)];
                break;
            case StickLongDown:
                [ballView setStickLong:(int) ([ballView getStickLong] * 2)];
                break;
            case StickLongMax:
                if(saveStickLong>ballView.size.width-10){
                    [ballView setStickLong:ballView.size.width/2];
                }else{
                    [ballView setStickLong:saveStickLong];
                }
                break;
            case BallRadiusUp:
                //				ball.setRadius((int) (ball.getRadius() * 0.67));
                self.ball.xScale = 1;
                self.ball.yScale = 1;
                break;
            case BallRadiusDown:
                //				ball.setRadius((int) (ball.getRadius() * 2));
                self.ball.xScale = 1;
                self.ball.yScale = 1;
                break;
        }
    }
}

-(CGRect) getToolRect {
    //    return toolRect;
    return toolRect;
}

//-(bool) isStartDownTool{
//    return self.isStartDownTool;
//}

-(void) moveDownToolObj{
    if(whichToolType != BlackHole){
        //        toolRect.offset(0, TOOL_DOWN_SPEED);
        self.position = CGPointMake(self.position.x, self.position.y - 2);
    }
}

-(TimerThread*) getToolTimerThread{
    return timerThread;
}

-(SKTexture*)getToolBitmap{
    return toolBitmap;
}

//int toolEffectTwinkingAlpha = 255;
//int toolEffectFinishAlpha = 255;
//
//-(int) getFinishAlpha{
//    return toolEffectFinishAlpha;
//}
//
//-(void) setFinishAlpha:(int) toolEffectFinishAlpha{
//    this.toolEffectFinishAlpha = toolEffectFinishAlpha;
//}
//
//-(int) getTwinklingAlpha{
//    return toolEffectTwinkingAlpha;
//}
//
//-(void) setTwinklingAlpha:(int) toolEffectTwinkingAlpha{
//    this.toolEffectTwinkingAlpha = toolEffectTwinkingAlpha;
//}
//
//const int Init_Max_Stick_Long_Count = 20;
//int count = Init_Max_Stick_Long_Count;
//
////Thread time = new Thread(new Runnable() {
////    public void run() {
////        boolean flag = true;
////        while (ballView.isBallRun() && flag) {
////            while (ballView.isGameRun()) {
////                try {
////                    Thread.sleep(1000);
////                } catch (InterruptedException e) {
////                    e.printStackTrace();
////                }
////                if (!flag) {
////                    break;
////                }
////                if (ballView.isGameRun()) {
////                    count--;
////                    flag = false;
////                    ((MainActivity) ballView.context).handler
////                    .sendEmptyMessage(6);
////                }
////            }
////        }
////    }
////});
//
@end
