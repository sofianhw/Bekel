//
//  GameScene.swift
//  Bekel
//
//  Created by Hendrik Tandabrata on 8/15/14.
//  Copyright (c) 2014 MannaCreatives. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var btnSizeW, btnSizeH:CGFloat!
    var frmWidth, frmHeight:CGFloat!
    
    var SetStat:Bool!
    
    // Start Level Variable
    var GamePages = ["01Stage", "02Stage", "03Stage", "04Stage", "05Stage", "06Stage", "07Stage", "08Stage", "09Stage", "10Stage", "11Stage", "12Stage", "13Stage", "14Stage", "15Stage"]
    var Balls = ["01Ball", "02Ball", "03Ball", "04Ball", "05Ball", "06Ball", "07Ball", "08Ball", "09Ball", "10Ball", "11Ball", "12Ball", "13Ball", "14Ball", "15Ball"]
    var Bijis = [["01Biji01", "01Biji02", "01Biji03", "01Biji04", "01Biji05", "01Biji06"],
        ["02Biji01", "02Biji02", "02Biji03", "02Biji04", "02Biji05", "02Biji06"],
        ["03Biji01", "03Biji02", "03Biji03", "03Biji04", "03Biji05", "03Biji06"],
        ["04Biji01", "04Biji02", "04Biji03", "04Biji04", "04Biji05", "04Biji06"],
        ["05Biji01", "05Biji02", "05Biji03", "05Biji04", "05Biji05", "05Biji06"],
        ["06Biji01", "06Biji02", "06Biji03", "06Biji04", "06Biji05", "06Biji06"],
        ["07Biji01", "07Biji02", "07Biji03", "07Biji04", "07Biji05", "07Biji06"],
        ["08Biji01", "08Biji02", "08Biji03", "08Biji04", "08Biji05", "08Biji06"],
        ["09Biji01", "09Biji02", "09Biji03", "09Biji04", "09Biji05", "09Biji06"],
        ["10Biji01", "10Biji02", "10Biji03", "10Biji04", "10Biji05", "10Biji06"],
        ["11Biji01", "11Biji02", "11Biji03", "11Biji04", "11Biji05", "11Biji06"],
        ["12Biji01", "12Biji02", "12Biji03", "12Biji04", "12Biji05", "12Biji06"],
        ["13Biji01", "13Biji02", "13Biji03", "13Biji04", "13Biji05", "13Biji06"],
        ["14Biji01", "14Biji02", "14Biji03", "14Biji04", "14Biji05", "14Biji06"],
        ["15Biji01", "15Biji02", "15Biji03", "15Biji04", "15Biji05", "15Biji06"]]
    var BijiPakuBoom = [[6,2,1],[6,3,1],[6,3,2],[6,4,2],[7,5,2] , [7,5,3],[7,6,3],[7,6,4],[8,6,4],[8,6,5] , [8,7,5],[8,7,6],[8,7,6],[8,7,7],[8,7,7]]
    var PakuSize: Array <CGFloat> = [1.0, 1.0, 1.0, 1.1, 1.15,  1.175, 1.2, 1.225, 1.25, 1.275,  1.275, 1.275, 1.275, 1.275, 1.275]
    var BoomSize: Array <CGFloat> = [1.0, 1.0, 1.0, 1.1, 1.15,  1.175, 1.2, 1.225, 1.25, 1.275,  1.275, 1.275, 1.275, 1.275, 1.275]
    // End Level Variable
    
    var MainPage, SetPage, GamePage, TutorialPage, SettingPage, GameOverPage, HighScorePage, AdvertPage:SKSpriteNode!
    
    var GamePlace:SKSpriteNode!
    
    @IBOutlet var MusicVol:UISlider!
    @IBOutlet var FlipSwitch:UISwitch!
    @IBOutlet var TutSwitch:UISwitch!
    
    var LogoText, LogoIcon:SKSpriteNode!
    var playBtn, setBtn, xBtn, outTutBtn, HSBtn, outHSBtn, pauseBtn, backBtn, SetBackground, GOWord, repBtn:SKSpriteNode!
    var scoreTitle, scoreLabel, scoreTitleShad, scoreLabelShad, timerLabel, timerLabelShad:SKLabelNode!
    var GOscore, ComboStat, ComboStatShad:SKLabelNode!
    var GOShare, GOFB, GOTW:SKSpriteNode!
    var resumeLbl, resumeYes, resumeNo, TutLabel:SKSpriteNode!
    var kenaPaku, kenaBoom, kenaJatoh, kenaOut:SKSpriteNode!
    var nextTut, prevTut, TutChkBtn, TutChkLabel, FlipLabel:SKSpriteNode!
    
    var BallPlace:SKSpriteNode!
    var Ball:SKSpriteNode!
    let BallCategory: UInt32 = 0x01
    let BallPlaceCategory: UInt32 = 0x02
    var BallContactCount:Int!
    
    var TutBallPlace:SKSpriteNode!
    var TutBall:SKSpriteNode!
    var TutBiji:SKSpriteNode!
    var TutBomb:SKSpriteNode!
    var TutPaku:SKSpriteNode!
    var TutHand:SKSpriteNode!
    var TutWord:SKSpriteNode!
    var TutX:SKSpriteNode!
    var TutCombo:SKLabelNode!
    
    var TutBallSwipe:Bool = false
    var TutTouch:Bool = false
    var TutBallSwipeA:Bool = false
    
    var Tutorial:Bool = true
    var FlipGameStat:Bool = false
    var FirstBoom:Bool = true
    var FirstPaku:Bool = true
    var TimePlaying:Bool!
    var pauseBall:Bool = false
    
    var TempVelocity:CGFloat!
    
    var FirstPlay, Lose, PickStat:Bool!
    var PakuTouch:Bool!
    
    var Biji, Paku, Boom:SKSpriteNode!
    var JumBiji:Int = 0
    var JumPaku:Int = 0
    var JumBoom:Int = 0
    var Score:Int = 0
    var Level:Int = 0
    var Combo:Int = 0
    
    var ChkStat:Bool! = false
    
    var TimerAddBiji:NSTimer!
    var TimerAddPaku:NSTimer!
    var TimerAddBoom:NSTimer!
    var TimerPakuMove:NSTimer!
    var TimerBoomMove:NSTimer!
    var GameTimer:NSTimer!
    var TimeNow:Int!
    var MaxBiji:Int!
    var MaxPaku:Int!
    var MaxBoom:Int!
    
    var XFade = [SKAction.fadeInWithDuration(0.3),SKAction.fadeOutWithDuration(0.3)]
    var Shake = [SKAction.scaleBy(1.8, duration: 0.1), SKAction.scaleBy(0.6, duration: 0.1)]
    
    var SFXclick = [SKAction.playSoundFileNamed("click.mp3", waitForCompletion: false)]
    var SFXpluck = [SKAction.playSoundFileNamed("pluck.mp3", waitForCompletion: false)]
    var SFXboom = [SKAction.playSoundFileNamed("boom.mp3", waitForCompletion: false)]
    var SFXboing = [SKAction.playSoundFileNamed("boing.mp3", waitForCompletion: false)]
    var SFXowow = [SKAction.playSoundFileNamed("owow.mp3", waitForCompletion: false)]
    var SFXclink = [SKAction.playSoundFileNamed("clink.mp3", waitForCompletion: false)]
    var SFXswipe = [SKAction.playSoundFileNamed("swipe.wav", waitForCompletion: false)]
    var SFXpop = [SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false)]
    var SFXmatch = [SKAction.playSoundFileNamed("match.mp3", waitForCompletion: false)]
    var SFXlevelup = [SKAction.playSoundFileNamed("levelup.mp3", waitForCompletion: false)]
    var SFXcombo = [SKAction.playSoundFileNamed("combo.mp3", waitForCompletion: false)]
    
    var error:NSError?
    var MSCgameover:AVAudioPlayer!
    var GameOverMusic = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("gameover", ofType: "mp3")!)
    var MSCmainpage:AVAudioPlayer!
    var MainPageMusic = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("goofy_loop", ofType: "mp3")!)
    var MSCgameplay:AVAudioPlayer!
    var GamePlayMusic = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("dufus", ofType: "mp3")!)
    
    let sparkLove = SKTexture(imageNamed: "PartLove")
    let sparkSmoke = SKTexture(imageNamed: "PartSmoke")
    
    var iosVer:String = UIDevice.currentDevice().systemVersion
    var iosV:Float!
    
    var advLabel:SKLabelNode!
    var advTime:Int!
    var advTimer:NSTimer!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        frmWidth = self.frame.size.width
        frmHeight = self.frame.size.height
        btnSizeW = frmHeight/10
        btnSizeH = frmHeight/7.6
        
        MSCgameover = AVAudioPlayer(contentsOfURL: GameOverMusic, error: &error)
        MSCgameover.prepareToPlay()
        MSCmainpage = AVAudioPlayer(contentsOfURL: MainPageMusic, error: &error)
        MSCmainpage.prepareToPlay()
        MSCmainpage.numberOfLoops = -1
        MSCgameplay = AVAudioPlayer(contentsOfURL: GamePlayMusic, error: &error)
        MSCgameplay.prepareToPlay()
        MSCgameplay.numberOfLoops = -1
        
        beginAdsApp()
        //.. ver 1.1 rep, begin after ads
        //beginApp()
        //.. ver 1.1 rep, triggerred by beginAdsApp
        //MSCmainpage.play()
        
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0,-5)
        
        iosV = (NSString(string: iosVer)).floatValue
        NSLog("\(iosVer)")
        NSLog("\(iosV)")
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(self)
        let touchNode:SKNode = self.nodeAtPoint(location)
        
        if touchNode.name != nil {
            if touchNode.name == "PlayBtn" {
                TimePlaying = false
                MSCmainpage.stop()
                MainPage.removeFromParent()
                StartGame()
                constructGamePage()
                MSCgameplay.play()
            }
            if touchNode.name == "PlayTimeBtn" {
                TimePlaying = true
                MSCmainpage.stop()
                MainPage.removeFromParent()
                StartGame()
                constructGamePage()
                MSCgameplay.play()
            }
            if touchNode.name == "RepBtn" {
                if TimePlaying == true {
                    TimePlaying = true
                } else {
                    TimePlaying = false
                }
                self.paused = false
                MSCgameover.stop()
                GameOverPage.removeFromParent()
                GamePage.removeFromParent()
                beginApp()
                MainPage.removeFromParent()
                constructGamePage()
                MSCgameplay.play()
            }
            if touchNode.name == "SetBtn" {
                constructSetPage()
                createSlider(0.3)
                createSwitch()
            }
            if touchNode.name == "OutSetPage" {
                SetPage.removeFromParent()
                removeSlider()
                removeSwitch()
            }
            if touchNode.name == "OutTutorial" {
                TutorialPage.removeFromParent()
                AddBiji()
                runAction(SKAction.sequence([SKAction.waitForDuration(1.0),
                    SKAction.runBlock { self.AddPaku() }
                    ]))
                runAction(SKAction.sequence([SKAction.waitForDuration(2.0),
                    SKAction.runBlock { self.AddBoom() }
                    ]))
                Lose = false
                TutBallSwipe = false
                TutTouch = false
                TutBallSwipeA = false
            }
            if touchNode.name == "HSBtn" {
                ConstructHighScorePage()
            }
            if touchNode.name == "OutHS" {
                HighScorePage.removeFromParent()
            }
            if touchNode.name == "PauseBtn" && SetStat == true && Lose == false {
                pauseGame()
                constructSettingPage()
                MSCgameplay.pause()
                createSlider(0.35)
            }
            if touchNode.name == "ResumeYesBtn" {
                resumeGame()
                MSCgameplay.play()
                removeSlider()
            }
            if touchNode.name == "ResumeNoBtn" {
                self.paused = false
                MSCgameplay.stop()
                SettingPage.removeFromParent()
                GamePage.removeFromParent()
                beginApp()
                MSCmainpage.play()
                removeSlider()
            }
            if touchNode.name == "BackBtn" {
                self.paused = false
                MSCgameover.stop()
                GameOverPage.removeFromParent()
                GamePage.removeFromParent()
                beginApp()
                MSCmainpage.play()
                //Ver 1.0 hide highscore
                //ConstructHighScorePage()
            }
            if touchNode.name == "BtnSFB" {
                NSLog("Share to FB")
                let a = FBLinkShareParams()
                a.link = NSURL(string: "http://crazyhackerz.com/bekel")
                a.name = "Bekel"
                if TimePlaying == true {
                    a.linkDescription = "Time Challange Score : \(scoreLabel.text)"
                } else {
                    a.linkDescription = "Your Score : \(scoreLabel.text)"
                }
                pauseGame()
                if(FBDialogs.canPresentMessageDialogWithParams(a)){
                    FBDialogs.presentShareDialogWithParams(a, clientState: nil, handler: handleError);
                }else{
                    FBWebDialogs.presentFeedDialogModallyWithSession(nil, parameters: nil, handler: handleErrors);
                }
            }
            if touchNode.name == "myBiji" {
                if PickStat == true {
                    runAction(SKAction.sequence(SFXclick))
                    touchNode.removeFromParent()
                    JumBiji = JumBiji - 1
                    Combo = Combo + 1
                    var myScoreGet:Int = 10
                    var myTimeGet:Int = 3
                    if Combo > 4 {
                        var myBonus:Int = Combo-2
                        myScoreGet = myScoreGet*myBonus
                    }
                    if TimerAddBiji == nil {
                        AddBiji()
                    }
                    
                    if TimePlaying == true {
                        if Combo > 4 {
                            ComboLabel(touchNode.position.x, Ypose: touchNode.position.y, Value: myTimeGet)
                            TimeNow = TimeNow + myTimeGet
                        }
                    } else {
                        if Combo > 4 {
                            ComboLabel(touchNode.position.x, Ypose: touchNode.position.y, Value: myScoreGet)
                        }
                    }
                    self.scoring(myScoreGet)
                    emitTouchedNode(touchNode.position.x, Ypose: touchNode.position.y, Black: false)
                    
                } else if Lose == false {
                    NSLog("Swipe First")
                }
            }
            if touchNode.name == "myPaku" {
                if PickStat == true && PakuTouch == true {
                    PakuTouch = false
                    Combo = 0
                    runAction(SKAction.sequence(SFXpluck))
                    runAction(SKAction.sequence([
                        SKAction.runBlock{
                            touchNode.physicsBody = nil;
                            self.Ball.texture = SKTexture(imageNamed: "\(self.Balls[self.Level])c")
                            touchNode.runAction(SKAction.repeatAction(SKAction.sequence(self.Shake), count: 3))
                        }, SKAction.waitForDuration(0.6) , SKAction.runBlock {
                            touchNode.removeFromParent()
                            self.emitTouchedNode(touchNode.position.x, Ypose: touchNode.position.y, Black: true)
                            self.KenaPaku();
                            self.JumPaku = self.JumPaku - 1
                            self.scoring(-10)
                            self.Ball.texture = SKTexture(imageNamed: "\(self.Balls[self.Level])a")
                            if self.TimerAddPaku == nil { self.AddPaku() }
                        }
                        ]))
                    
                }
            }
            if touchNode.name == "myBoom" {
                if PickStat == true {
                    SetStat = false
                    runAction(SKAction.sequence([
                        SKAction.runBlock{
                            self.runAction(SKAction.sequence(self.SFXmatch))
                            touchNode.physicsBody = nil;
                            self.Ball.texture = SKTexture(imageNamed: "\(self.Balls[self.Level])c");
                            touchNode.runAction(SKAction.repeatAction(SKAction.sequence(self.Shake), count: 3))
                        }, SKAction.waitForDuration(0.6) , SKAction.runBlock {
                            touchNode.removeFromParent();
                            self.runAction(SKAction.sequence(self.SFXboom))
                            self.KenaBoom();
                        }
                        ]))
                    Ball.physicsBody?.dynamic = false
                    Ball.physicsBody?.affectedByGravity = false
                }
            }
            if touchNode.name == "TutChkBtn" {
                ChkChange()
            }
            if touchNode.name == "myTutBiji" {
                if TutTouch == true {
                    runAction(SKAction.sequence(SFXclick))
                    TutorialPlay3()
                    TutTouch = false
                }
            }
        }
    }
    
    func handleBallSwipe(gestureRecognizer: UISwipeGestureRecognizer)  {
        if (gestureRecognizer.state == UIGestureRecognizerState.Ended)
        {
            var touchlocation:CGPoint = gestureRecognizer.locationInView(gestureRecognizer.view)
            touchlocation = self.convertPointFromView(touchlocation)
            var touchedNode:SKNode = self.nodeAtPoint(touchlocation) as SKNode
            if (touchedNode.name != nil) {
                if touchedNode.name == "myBall" && Lose == false {
                    if pauseBall == false {
                        BallPlace.texture = SKTexture(imageNamed: "BallPlace")
                        Ball.physicsBody?.affectedByGravity = true
                        if Ball.physicsBody?.velocity.dy < 0 {
                            Ball.physicsBody?.velocity = CGVectorMake(0, 0)
                        }
                        if BallContactCount == 0 && FirstPlay == true {
                            Ball.physicsBody?.velocity.dy = frmHeight
                            FirstPlay = false
                            PickStat = true
                            if TimePlaying == true {
                                startTimer()
                            }
                        } else if BallContactCount == 0 && FirstPlay == false {
                            NSLog("Not Yet")
                        } else {
                            Ball.physicsBody?.applyImpulse(CGVectorMake(0, frmHeight*0.6))
                            if Ball.physicsBody?.velocity.dy > 900 {
                                Ball.physicsBody?.velocity.dy = 900
                            }
                        }
                        BallContactCount = 0
                        let ChangeBall = [ SKAction.runBlock { self.Ball.texture = SKTexture(imageNamed: "\(self.Balls[self.Level])b") },
                            SKAction.waitForDuration(0.5), SKAction.runBlock { self.Ball.texture = SKTexture(imageNamed: "\(self.Balls[self.Level])a")}]
                        runAction(SKAction.sequence(SFXswipe))
                        runAction(SKAction.sequence(ChangeBall))
                        MovePaku()
                        if BijiPakuBoom[Level][2] != 0 {
                            MoveBoom()
                        }
                        if Level > 1 {
                            MoveBiji()
                        }
                    }
                }
                if touchedNode.name == "myTutBall" && TutBallSwipe == true {
                    TutBallSwipe = false
                    let ChangeTutBall = [ SKAction.runBlock { self.TutBall.texture = SKTexture(imageNamed: "01Ballb") },
                        SKAction.waitForDuration(0.5), SKAction.runBlock { self.TutBall.texture = SKTexture(imageNamed: "01Balla")}]
                    runAction(SKAction.sequence(SFXswipe))
                    runAction(SKAction.sequence(ChangeTutBall))
                    TutorialPlay2()
                }
                if touchedNode.name == "myTutBall" && TutBallSwipeA == true {
                    TutBallSwipeA = false
                    TutorialPlay4()
                }
            }
        }
    }
    
    func beginAdsApp() {
        constructAdvertPage()
    }
    
    func beginApp() {
        constructMainPage()
        SetStat = true
    }
    
    func pauseGame() {
        SetStat = false
        //.. refine pause system , do not use app pause
        //self.paused = true
        TempVelocity = Ball.physicsBody?.velocity.dy
        Ball.physicsBody?.velocity = CGVectorMake(0, 0)
        Ball.physicsBody?.affectedByGravity = false
        PickStat = false
        pauseBall = true
        stopAddBiji()
        stopAddPaku()
        stopAddBoom()
        if TimePlaying == true {
            if GameTimer != nil {
                GameTimer.invalidate()
            }
        }
    }
    
    func resumeGame() {
        SettingPage.removeFromParent()
        pauseBall = false
        SetStat = true
        //.. refine pause system
        //self.paused = false
        Ball.physicsBody?.velocity = CGVectorMake(0, TempVelocity)
        pauseBtn.hidden = false
        var GetDy = Ball.physicsBody?.velocity.dy
        
        if FirstPlay == false {
            PickStat = true
            Ball.physicsBody?.affectedByGravity =  true
        } else {
            PickStat = false
        }
        if TimePlaying == true {
            startTimer()
        }
        resumeAdd()
        
        //Hole for test .. test mode, di uncomment aja PickStat = true
        //PickStat = true
    }
    
    func resumeAdd() {
        if JumBiji < MaxBiji {
            if TimerAddBiji == nil {
                AddBiji()
            }
        }
        if JumPaku < MaxPaku {
            if TimerAddPaku == nil {
                AddPaku()
            }
        }
        if JumBoom < MaxBoom {
            if TimerAddBoom == nil {
                AddBoom()
            }
        }
    }
    
    func scoring(scoreVal:Int!) {
        Score = Score+scoreVal;
        var Scoretext = Score;
        scoreLabel.text = ("\(Scoretext)");
        scoreLabelShad.text = ("\(Scoretext)");
        
        // Kontrol Score buat naik level Cuy
        if Score >= 1000 && Score < 2000 {
            if Level != 1 {
                Level = 1
                ChangeLevel()
            }
        } else if Score >= 2000 && Score < 3000 {
            if Level != 2 {
                Level = 2
                ChangeLevel()
            }
        } else if Score >= 3000 && Score < 4000 {
            if Level != 3 {
                Level = 3
                ChangeLevel()
            }
        } else if Score >= 4000 && Score < 5000 {
            if Level != 4 {
                Level = 4
                ChangeLevel()
            }
        } else if Score >= 5000 && Score < 6000 {
            if Level != 5 {
                Level = 5
                ChangeLevel()
            }
        } else if Score >= 6000 && Score < 7000 {
            if Level != 6 {
                Level = 6
                ChangeLevel()
            }
        } else if Score >= 7000 && Score < 8000 {
            if Level != 7 {
                Level = 7
                ChangeLevel()
            }
        } else if Score >= 8000 && Score < 9000 {
            if Level != 8 {
                Level = 8
                ChangeLevel()
            }
        } else if Score >= 9000 && Score < 10000 {
            if Level != 9 {
                Level = 9
                ChangeLevel()
            }
        } else if Score >= 10000 && Score < 11000 {
            if Level != 10 {
                Level = 10
                ChangeLevel()
            }
        } else if Score >= 11000 && Score < 12000 {
            if Level != 11 {
                Level = 11
                ChangeLevel()
            }
        } else if Score >= 12000 && Score < 13000 {
            if Level != 12 {
                Level = 12
                ChangeLevel()
            }
        } else if Score >= 13000 && Score < 14000 {
            if Level != 13 {
                Level = 13
                ChangeLevel()
            }
        } else if Score >= 14000 && Score < 15000 {
            if Level != 14 {
                Level = 14
                ChangeLevel()
            }
        } else if Score >= 15000 {
            if Level != 14 {
                Level = 14
                ChangeLevel()
            }
        }
    }
    
    func ChangeLevel() {
        runAction(SKAction.sequence(SFXlevelup))
        emitLevel()
        Ball.texture = SKTexture(imageNamed: "\(Balls[Level])a")
        GamePage.texture = SKTexture(imageNamed: "\(GamePages[Level])")
        MaxBiji = BijiPakuBoom[Level][0]
        MaxPaku = BijiPakuBoom[Level][1]
        MaxBoom = BijiPakuBoom[Level][2]
        AddBiji()
        AddPaku()
        AddBoom()
        let BoomResize = [SKAction.waitForDuration(1.2), SKAction.runBlock {
            self.GamePlace.enumerateChildNodesWithName("myBoom", usingBlock: { node, stop in
                node.runAction(SKAction.scaleTo(self.BoomSize[self.Level], duration: 0.3))
            })
            }]
        runAction(SKAction.sequence(BoomResize))
        let PakuResize = [SKAction.waitForDuration(1.2), SKAction.runBlock {
            self.GamePlace.enumerateChildNodesWithName("myPaku", usingBlock: { node, stop in
                node.runAction(SKAction.scaleTo(self.PakuSize[self.Level], duration: 0.3))
            })
            }]
        runAction(SKAction.sequence(PakuResize))
    }
    
    func constructAdvertPage() {
        AdvertPage = SKSpriteNode(imageNamed: "myLaunchImage")
        AdvertPage.size = self.frame.size
        AdvertPage.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(AdvertPage)
        
        advTime = 5
        advLabel = SKLabelNode(fontNamed: "Noteworthy-Bold")
        advLabel.text = "This Advertisement will automatically close in \(advTime) seconds"
        advLabel.fontSize = 20.0
        advLabel.fontColor = SKColor.whiteColor()
        advLabel.position = CGPointMake((frmWidth*0.5)-((advLabel.frame.size.width)*0.5)-15, (frmHeight*0.5)-30)
        let myLaunchImg = [SKAction.waitForDuration(3.0), SKAction.runBlock {
            self.AdvertPage.texture = SKTexture(imageNamed: "Advert")
            self.AdvertPage.addChild(self.advLabel)
            self.AdvertTimer()
            }]
        runAction(SKAction.sequence(myLaunchImg))
        
    }
    
    func AdvertTimer() {
        advTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("AdvActTimer"), userInfo: nil, repeats: true)
    }
    
    func AdvActTimer() {
        var advTimeNow:Int = advTime - 1
        advLabel.text = "This Advertisement will automatically close in \(advTimeNow) seconds"
        advTime = advTimeNow
        if advTime <= 0 {
            if advTimer != nil {
                advTimer.invalidate()
            }
            runAction(SKAction.sequence([
                //SKAction.waitForDuration(5.0),
                SKAction.runBlock {
                    self.AdvertPage.runAction(SKAction.fadeOutWithDuration(0.3));
                }, SKAction.waitForDuration(0.3),
                SKAction.runBlock {
                    self.AdvertPage.removeFromParent()
                    self.beginApp();
                    self.MSCmainpage.play();
                }
                ]))
        }
    }
    
    func constructMainPage() {
        MainPage = SKSpriteNode(imageNamed: "MainBG")
        MainPage.size = self.frame.size
        MainPage.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(MainPage)
        
        var LogoTextShadow = SKSpriteNode(imageNamed: "BayanganFont")
        LogoTextShadow.size = CGSizeMake(btnSizeW*4.7, btnSizeH*0.6)
        LogoTextShadow.position = CGPointMake(0-btnSizeW*1.1, 0-btnSizeH*1.9)
        MainPage.addChild(LogoTextShadow)
        
        LogoText = SKSpriteNode(imageNamed: "MainText")
        LogoText.size = CGSizeMake(frmWidth*0.35, frmHeight*0.55)
        LogoText.position = CGPointMake(0-(btnSizeW*1.2), btnSizeH*0.9)
        MainPage.addChild(LogoText)
        
        let ShadShaker = [SKAction.moveToX(0-(btnSizeW*1.3), duration: 0.1), SKAction.moveToX(0-(btnSizeW*1.2), duration: 0.1)]
        let TextShadShake = [SKAction.waitForDuration(1.5), SKAction.repeatAction(SKAction.sequence(ShadShaker), count: 5), SKAction.waitForDuration(5)]
        LogoTextShadow.runAction(SKAction.repeatActionForever(SKAction.sequence(TextShadShake)))
        
        let Shaker = [SKAction.rotateToAngle(0.04, duration: 0.1), SKAction.rotateToAngle(-0.04, duration: 0.1)]
        let TextShake = [SKAction.waitForDuration(1.5), SKAction.repeatAction(SKAction.sequence(Shaker), count: 5), SKAction.waitForDuration(5)]
        LogoText.runAction(SKAction.repeatActionForever(SKAction.sequence(TextShake)))
        
        var LogoIconShadow = SKSpriteNode(imageNamed: "Bayangan")
        LogoIconShadow.size = CGSizeMake(btnSizeW*1.5, btnSizeH*0.6)
        LogoIconShadow.position = CGPointMake(btnSizeW*2.3, 0-btnSizeH*1.5)
        MainPage.addChild(LogoIconShadow)
        let Mover = [SKAction.scaleTo(0.2, duration: 0.0), SKAction.waitForDuration(1.0), SKAction.scaleTo(2.0, duration: 0.35), SKAction.scaleTo(1.0, duration: 0.15), SKAction.waitForDuration(5.7), SKAction.scaleTo(0.2, duration: 0.2), SKAction.waitForDuration(0.1)]
        LogoIconShadow.runAction(SKAction.repeatActionForever(SKAction.sequence(Mover)))
        
        LogoIcon = SKSpriteNode(imageNamed: "MainLogo")
        LogoIcon.size = CGSizeMake(frmWidth*0.22, frmHeight*0.435)
        LogoIcon.position = CGPointMake(btnSizeW*2.3, frmHeight*0.8)
        MainPage.addChild(LogoIcon)
        let Droper = [SKAction.waitForDuration(1.0), SKAction.moveTo(CGPointMake(btnSizeW*2.3, btnSizeH*0.4), duration: 0.35), SKAction.moveTo(CGPointMake(btnSizeW*2.3, btnSizeH*1.4), duration: 0.15), SKAction.waitForDuration(5.7), SKAction.moveTo(CGPointMake(btnSizeW*2.3, frmHeight*0.8), duration: 0.2), SKAction.waitForDuration(0.1)]
        LogoIcon.runAction(SKAction.repeatActionForever(SKAction.sequence(Droper)))
        
        playBtn = SKSpriteNode(imageNamed: "BtnPlayNormal") as SKSpriteNode
        playBtn.name = "PlayBtn"
        playBtn.size = CGSizeMake(btnSizeW*4.15, btnSizeH*1.5)
        playBtn.position = CGPointMake(0-(btnSizeW*2.9), 0-(MainPage.frame.height*0.30))
        MainPage.addChild(playBtn)
        
        playBtn = SKSpriteNode(imageNamed: "BtnPlayMinute") as SKSpriteNode
        playBtn.name = "PlayTimeBtn"
        playBtn.size = CGSizeMake(btnSizeW*4.8, btnSizeH*1.5)
        playBtn.position = CGPointMake(0+(btnSizeW*2.4), 0-(MainPage.frame.height*0.30))
        MainPage.addChild(playBtn)
        SetStat = true
        
        setBtn = SKSpriteNode(imageNamed: "BtnSet") as SKSpriteNode
        setBtn.name = "SetBtn"
        setBtn.size = CGSizeMake(btnSizeW, btnSizeH)
        setBtn.position = CGPointMake((frmWidth/2)-(btnSizeW*0.7), (frmHeight/2)-(btnSizeH*0.7))
        MainPage.addChild(setBtn)
        
        HSBtn = SKSpriteNode(imageNamed: "BtnHS") as SKSpriteNode
        HSBtn.name = "HSBtn"
        HSBtn.size = CGSizeMake(btnSizeW, btnSizeH)
        HSBtn.position = CGPointMake((frmWidth/2)-(btnSizeW*0.7), (frmHeight/2)-(btnSizeH*2))
        // MainPage.addChild(HSBtn)
    }
    
    func constructSetPage() {
        SetPage = SKSpriteNode(color: UIColor(white: 0, alpha: 0.65), size: self.frame.size)
        SetPage.position = CGPoint(x:0, y:0)
        MainPage.addChild(SetPage)
        
        SetBackground = SKSpriteNode(imageNamed: "SettingBG")
        SetBackground.size = CGSizeMake(frmWidth*0.5, frmHeight*0.5)
        SetBackground.position = CGPointZero
        SetPage.addChild(SetBackground)
        
        xBtn = SKSpriteNode(imageNamed: "BtnNo")
        xBtn.name = "OutSetPage"
        xBtn.size = CGSizeMake(btnSizeW, btnSizeH)
        xBtn.position = CGPointMake(frmWidth/4, frmHeight/4)
        SetBackground.addChild(xBtn)
    }
    
    func constructGamePage() {
        GamePage = SKSpriteNode(imageNamed: "01Stage")
        GamePage.size = self.frame.size
        GamePage.anchorPoint = CGPointZero
        self.addChild(GamePage)
        
        StartGame()
        
        constructGame()
        
        scoreTitleShad = SKLabelNode(fontNamed: "Noteworthy-Bold")
        scoreTitleShad.text = "Score"
        scoreTitleShad.fontSize = 30.0
        scoreTitleShad.fontColor = SKColor.blackColor()
        scoreTitleShad.position = CGPointMake(frmWidth*0.45, frmHeight-(btnSizeH*0.4))
        GamePage.addChild(scoreTitleShad)
        scoreTitle = SKLabelNode(fontNamed: "Noteworthy-Bold")
        scoreTitle.text = "Score"
        scoreTitle.fontSize = 30.0
        scoreTitle.fontColor = SKColor.whiteColor()
        scoreTitle.position = CGPointMake(-2,4)
        scoreTitleShad.addChild(scoreTitle)
        
        scoreLabelShad = SKLabelNode(fontNamed: "Noteworthy-Bold")
        scoreLabelShad.text = "00"
        scoreLabelShad.fontSize = 36.0
        scoreLabelShad.fontColor = SKColor.blackColor()
        scoreLabelShad.position = CGPointMake(frmWidth*0.45, frmHeight-(btnSizeH*0.8))
        GamePage.addChild(scoreLabelShad)
        scoreLabel = SKLabelNode(fontNamed: "Noteworthy-Bold")
        scoreLabel.text = "00"
        scoreLabel.fontSize = 36.0
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.position = CGPointMake(-2,4)
        scoreLabelShad.addChild(scoreLabel)
        
        pauseBtn = SKSpriteNode(imageNamed: "BtnPause")
        pauseBtn.name = "PauseBtn"
        pauseBtn.size = CGSizeMake(btnSizeW, btnSizeH)
        pauseBtn.position = CGPointMake(btnSizeW/2, frmHeight-btnSizeH/2)
        GamePage.addChild(pauseBtn)
        
        if TimePlaying == true {
            scoreTitleShad.position = CGPointMake(frmWidth*0.35, frmHeight-(btnSizeH*0.4))
            scoreLabelShad.position = CGPointMake(frmWidth*0.35, frmHeight-(btnSizeH*0.8))
            AddTimer()
        }
        
        if FlipGameStat == true {
            FlipGame()
        } else {
            UnFlipGame()
        }
    }
    
    func constructSettingPage() {
        SettingPage = SKSpriteNode(color: UIColor(white: 0, alpha: 0.65), size: self.frame.size)
        SettingPage.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(SettingPage)
        
        SetBackground = SKSpriteNode(imageNamed: "SettingBG")
        SetBackground.size = CGSizeMake(frmWidth*0.5, frmHeight*0.5)
        SetBackground.position = CGPointZero
        SettingPage.addChild(SetBackground)
        
        resumeLbl = SKSpriteNode(imageNamed: "BtnResume")
        resumeLbl.size = CGSizeMake(btnSizeW*3.2, btnSizeH*0.6)
        resumeLbl.position = CGPointMake(0, 0-(frmHeight/4)+(btnSizeH*1.7))
        SetBackground.addChild(resumeLbl)
        
        resumeYes = SKSpriteNode(imageNamed: "BtnYes")
        resumeYes.name = "ResumeYesBtn"
        resumeYes.size = CGSizeMake(btnSizeW, btnSizeH)
        resumeYes.position = CGPointMake(0-btnSizeW, 0-(frmHeight/4)+(btnSizeH*0.85))
        SetBackground.addChild(resumeYes)
        
        resumeNo = SKSpriteNode(imageNamed: "BtnNo")
        resumeNo.name = "ResumeNoBtn"
        resumeNo.size = CGSizeMake(btnSizeW, btnSizeH)
        resumeNo.position = CGPointMake(0+btnSizeW, 0-(frmHeight/4)+(btnSizeH*0.85))
        SetBackground.addChild(resumeNo)
    }
    
    func constructGame() {
        GamePlace = SKSpriteNode(imageNamed: "Blank")
        GamePlace.size = CGSizeMake(frmWidth-(btnSizeW*2)-(btnSizeW/2), frmHeight-(btnSizeH/4))
        GamePlace.anchorPoint = CGPointMake(0, 0)
        GamePlace.position = CGPointMake(btnSizeW/4, btnSizeH/4)
        GamePage.addChild(GamePlace)
        GamePlace.physicsBody = SKPhysicsBody (edgeLoopFromRect: GamePlace.frame)
        //GamePlace.physicsBody?.usesPreciseCollisionDetection = true
        
        BallPlace = SKSpriteNode(imageNamed: "BallPlaceArrow")
        BallPlace.name = "myBallPlace"
        BallPlace.size = CGSizeMake(btnSizeW*2, btnSizeH*7.5)
        BallPlace.position = CGPointMake(frmWidth-(btnSizeW), frmHeight/2)
        GamePage.addChild(BallPlace)
        BallPlace.physicsBody = SKPhysicsBody (edgeLoopFromRect: CGRectMake((-BallPlace.frame.size.width/2), (-BallPlace.frame.size.height/2)+(btnSizeH/4), BallPlace.frame.size.width, BallPlace.frame.size.height+(frmHeight/2)))
        BallPlace.physicsBody?.usesPreciseCollisionDetection = true
        BallPlace.physicsBody?.categoryBitMask = BallPlaceCategory
        BallPlace.physicsBody?.contactTestBitMask = BallCategory
        
        Ball = SKSpriteNode(imageNamed: "\(Balls[Level])a")
        Ball.name = "myBall"
        Ball.size = CGSizeMake(btnSizeW*1.65, btnSizeH*1.65)
        Ball.position = CGPointMake(0, 0-BallPlace.frame.size.height/4)
        BallPlace.addChild(Ball)
        Ball.physicsBody = SKPhysicsBody(circleOfRadius: Ball.frame.size.width/2)
        Ball.physicsBody?.affectedByGravity = false
        Ball.physicsBody?.dynamic = true
        Ball.physicsBody?.allowsRotation = false
        Ball.physicsBody?.mass = 1
        Ball.physicsBody?.friction = 0.2
        Ball.physicsBody?.restitution = 0.85
        Ball.physicsBody?.linearDamping = 0.2
        Ball.physicsBody?.usesPreciseCollisionDetection = true
        Ball.physicsBody?.categoryBitMask = BallCategory
        Ball.physicsBody?.contactTestBitMask = BallPlaceCategory
        
        if Tutorial == true {
            ConstuctTutorialPage()
            FirstPaku = true
            FirstBoom = true
        } else {
            AddBiji()
            runAction(SKAction.sequence([SKAction.waitForDuration(1.0),
                SKAction.runBlock { self.AddPaku() }
                ]))
            runAction(SKAction.sequence([SKAction.waitForDuration(2.0),
                SKAction.runBlock { self.AddBoom() }
                ]))
        }
        
        addBallSwipe()
    }
    
    func ConstuctTutorialPage() {
        TutorialPage = SKSpriteNode(imageNamed: "01Stage")
        TutorialPage.size = self.size
        TutorialPage.anchorPoint = CGPointZero
        TutorialPage.position = CGPoint(x:0, y:0)
        self.addChild(TutorialPage)
        
        TutorialPlay()
        
        outTutBtn = SKSpriteNode(imageNamed: "BtnNo") as SKSpriteNode
        outTutBtn.name = "OutTutorial"
        outTutBtn.size = CGSizeMake(btnSizeW*1.0, btnSizeH*1.0)
        outTutBtn.position = CGPointMake(btnSizeW/2, frmHeight-btnSizeH/2)
        TutorialPage.addChild(outTutBtn)
        
        Lose = true
        
        createTutChk()
    }
    
    func TutorialPlay() {
        TutBallPlace = SKSpriteNode(imageNamed: "BallPlaceArrow")
        TutBallPlace.name = "myTutBallPlace"
        TutBallPlace.size = CGSizeMake(btnSizeW*2, btnSizeH*7.5)
        TutBallPlace.position = CGPointMake(frmWidth-(btnSizeW), frmHeight/2)
        TutorialPage.addChild(TutBallPlace)
        
        TutBall = SKSpriteNode(imageNamed: "\(Balls[0])a")
        TutBall.name = "myTutBall"
        TutBall.size = CGSizeMake(btnSizeW*1.65, btnSizeH*1.65)
        TutBall.position = CGPointMake(0, 0-TutBallPlace.frame.size.height/4)
        TutBallPlace.addChild(TutBall)
        
        var TutBijiPoss = [
            [self.frmWidth/5.8, self.frmHeight/1.8],
            [self.frmWidth/4.75, self.frmHeight/3.5],
            [self.frmWidth/2.75, self.frmHeight/2.2],
            [self.frmWidth/2.5, self.frmHeight/3.8],
            [self.frmWidth/1.5, self.frmHeight/1.65],
            [self.frmWidth/1.35, self.frmHeight/2]]
        
        var TutIdx:Int = 0
        
        for TutBijiPos in TutBijiPoss {
            let TutDropBiji = [
                SKAction.waitForDuration(NSTimeInterval(Float(TutIdx)*0.3)),
                SKAction.runBlock {
                    var TutIdxBiji:Int = Int(arc4random() % UInt32(self.Bijis[0].count))
                    self.TutBiji = SKSpriteNode(imageNamed: "\(self.Bijis[0][TutIdxBiji])")
                    self.TutBiji.name = "myTutBiji"
                    self.TutBiji.size = CGSizeMake(self.btnSizeW*0.85, self.btnSizeH*0.85)
                    self.TutBiji.position = CGPointMake(TutBijiPos[0], self.frmHeight)
                    self.TutBiji.physicsBody = SKPhysicsBody(circleOfRadius: self.TutBiji.frame.size.height/1.8)
                    self.TutBiji.physicsBody?.usesPreciseCollisionDetection = true
                    self.TutBiji.physicsBody?.affectedByGravity = false
                    self.TutBiji.physicsBody?.allowsRotation = false
                    self.TutorialPage.addChild(self.TutBiji)
                    self.TutBiji.runAction(SKAction.moveTo(CGPointMake(TutBijiPos[0], TutBijiPos[1]), duration: 0.3))
                },
                SKAction.waitForDuration(0.3),
                SFXpop
            ]
            runAction(SKAction.sequence(TutDropBiji))
            TutIdx = TutIdx+1
        }
        
        TutPaku = SKSpriteNode(imageNamed: "Paku")
        TutPaku.name = "myTutPaku"
        TutPaku.size = CGSizeMake(btnSizeW*0.85, btnSizeH*0.85)
        TutPaku.position = CGPointMake(frmWidth/6, frmHeight)
        TutPaku.physicsBody = SKPhysicsBody(circleOfRadius: TutPaku.frame.size.height/2)
        TutPaku.physicsBody?.usesPreciseCollisionDetection = true
        TutPaku.physicsBody?.affectedByGravity = false
        TutPaku.physicsBody?.allowsRotation = false
        
        TutBomb = SKSpriteNode(imageNamed: "Boom")
        TutBomb.name = "myTutBoom"
        TutBomb.size = CGSizeMake(btnSizeW*0.85, btnSizeH*0.85)
        TutBomb.position = CGPointMake(frmWidth/1.6, frmHeight)
        TutBomb.physicsBody = SKPhysicsBody(circleOfRadius: TutPaku.frame.size.height/2)
        TutBomb.physicsBody?.usesPreciseCollisionDetection = true
        TutBomb.physicsBody?.affectedByGravity = false
        TutBomb.physicsBody?.allowsRotation = false
        
        let TutDropPakuBomb = [
            SKAction.waitForDuration(1.5),
            SKAction.runBlock {
                self.TutorialPage.addChild(self.TutPaku)
                self.TutPaku.runAction(SKAction.moveTo(CGPointMake(self.frmWidth/6, self.frmHeight/3.0), duration: 0.3))
            },
            SKAction.waitForDuration(0.3),
            SFXclink,
            SKAction.waitForDuration(0.3),
            SKAction.runBlock {
                self.TutorialPage.addChild(self.TutBomb)
                self.TutBomb.runAction(SKAction.moveTo(CGPointMake(self.frmWidth/1.6, self.frmHeight/2.35), duration: 0.3))
            },
            SKAction.waitForDuration(0.3),
            SFXclink
        ]
        runAction(SKAction.sequence(TutDropPakuBomb))
        
        TutHand = SKSpriteNode(imageNamed: "TutHandR")
        TutHand.name = "myTutHand"
        TutHand.size = CGSizeMake(btnSizeW*3, btnSizeH*4)
        TutHand.position = CGPointMake(frmWidth+(btnSizeW*0.35), 0+(btnSizeH*0.1))
        
        TutWord = SKSpriteNode(imageNamed: "TutWord01")
        TutWord.name = "myTutWord01"
        TutWord.size = CGSizeMake(btnSizeW*10, btnSizeW*2)
        TutWord.position = CGPointMake((frmWidth*0.5)-(btnSizeW*0.75), (frmHeight*0.5)+(btnSizeH*2.1))
        
        let TutStory = [
            SKAction.waitForDuration(2.5),
            SKAction.runBlock {
                self.TutorialPage.texture = SKTexture(imageNamed: "TutNeoBg")
                self.TutorialPage.enumerateChildNodesWithName("myTutBiji", usingBlock: { node, stop in
                    node.alpha = 0.5
                })
                self.TutPaku.alpha = 0.5
                self.TutBomb.alpha = 0.5
                self.TutorialPage.addChild(self.TutHand)
                self.TutorialPage.addChild(self.TutWord)
            },
            SKAction.waitForDuration(1.0),
            SKAction.runBlock {
                self.TutHand.runAction(SKAction.moveTo(CGPointMake(self.frmWidth+(self.btnSizeW*0.35), 0+(self.btnSizeH*4.7)), duration: 0.8))
            },
            SKAction.waitForDuration(2.0),
            SKAction.runBlock {
                self.TutHand.runAction(SKAction.fadeOutWithDuration(0.5))
                self.TutHand.runAction(SKAction.moveTo(CGPointMake(self.frmWidth+(self.btnSizeW*0.35), 0+(self.btnSizeH*0.1)), duration: 0.5))
            },
            SKAction.waitForDuration(0.5),
            SKAction.runBlock {
                self.TutBallSwipe = true
            }
        ]
        runAction(SKAction.sequence(TutStory))
    }
    
    func TutorialPlay2() {
        TutWord.alpha = 0.0
        TutWord.texture = SKTexture(imageNamed: "TutWord02")
        TutWord.size = CGSizeMake(btnSizeW*10, btnSizeW*2)
        TutWord.position = CGPointMake((frmWidth*0.5)-(btnSizeW*0.6), (frmHeight*0.5)+(btnSizeH*2))
        
        TutHand.texture = SKTexture(imageNamed: "TutHandL")
        TutHand.position = CGPointMake(frmWidth*0.565, frmHeight*0.35)
        
        let TutSecond = [
            SKAction.runBlock {
                let TutBallUp = [
                    SKAction.moveTo(CGPointMake(0, self.TutBallPlace.frame.size.height*0.15), duration: 0.6),
                    SKAction.moveTo(CGPointMake(0, self.TutBallPlace.frame.size.height*0.25), duration: 0.6),
                    SKAction.moveTo(CGPointMake(0, self.TutBallPlace.frame.size.height*0.3), duration: 0.6)
                ]
                self.TutBall.runAction(SKAction.sequence(TutBallUp))
            },
            SKAction.waitForDuration(1.5),
            SKAction.runBlock {
                self.TutWord.alpha = 1.0
                self.TutorialPage.enumerateChildNodesWithName("myTutBiji", usingBlock: { node, stop in
                    node.alpha = 1
                })
                self.TutBallPlace.alpha = 0.3
            },
            SKAction.waitForDuration(0.5),
            SKAction.runBlock {
                self.TutHand.runAction(SKAction.fadeInWithDuration(0.5))
            },
            SKAction.waitForDuration(0.8),
            SKAction.runBlock {
                self.TutHand.runAction(SKAction.fadeOutWithDuration(0.3))
                self.TutTouch = true
            }
        ]
        runAction(SKAction.sequence(TutSecond))
    }
    
    func TutorialPlay3() {
        TutWord.alpha = 0.0
        TutWord.texture = SKTexture(imageNamed: "TutWord03")
        TutWord.size = CGSizeMake(btnSizeW*10, btnSizeW*2)
        TutWord.position = CGPointMake((frmWidth*0.5)-(btnSizeW*0.75), (frmHeight*0.5)+(btnSizeH*2))
        
        TutHand.texture = SKTexture(imageNamed: "TutHandR")
        TutHand.position = CGPointMake(frmWidth+(btnSizeW*0.35), 0+(btnSizeH*0.55))
        
        let TutThree = [
            SKAction.waitForDuration(0.5),
            SKAction.runBlock {
                self.TutWord.alpha = 1.0
                self.TutorialPage.enumerateChildNodesWithName("myTutBiji", usingBlock: { node, stop in
                    node.alpha = 0.5
                })
                self.TutBallPlace.alpha = 1
            },
            SKAction.waitForDuration(0.5),
            SKAction.runBlock {
                let TutBallDown = [
                    SKAction.moveTo(CGPointMake(0, 0), duration: 0.6),
                    SKAction.moveTo(CGPointMake(0, 0-self.TutBallPlace.frame.size.height*0.38), duration: 0.6),
                    SKAction.sequence(self.SFXboing),
                    SKAction.moveTo(CGPointMake(0, 0-self.TutBallPlace.frame.size.height*0.1), duration: 0.8)
                ]
                self.TutBall.runAction(SKAction.sequence(TutBallDown))
            },
            SKAction.waitForDuration(2.5),
            SKAction.runBlock {
                self.TutHand.alpha = 1.0
                self.TutHand.runAction(SKAction.moveTo(CGPointMake(self.frmWidth+(self.btnSizeW*0.35), 0+(self.btnSizeH*4.7)), duration: 0.8))
            },
            SKAction.waitForDuration(2.0),
            SKAction.runBlock {
                self.TutHand.runAction(SKAction.fadeOutWithDuration(0.5))
                self.TutHand.runAction(SKAction.moveTo(CGPointMake(self.frmWidth+(self.btnSizeW*0.35), 0+(self.btnSizeH*0.1)), duration: 0.5))
            },
            SKAction.waitForDuration(0.5),
            SKAction.runBlock {
                self.TutBallSwipeA = true
            }
        ]
        runAction(SKAction.sequence(TutThree))
    }
    
    func TutorialPlay4() {
        TutWord.alpha = 0.0
        TutWord.texture = SKTexture(imageNamed: "TutWord04")
        TutWord.size = CGSizeMake(btnSizeW*10, btnSizeW*2)
        TutWord.position = CGPointMake((frmWidth*0.5)+(btnSizeW*0.2), (frmHeight*0.5))
        
        TutX = SKSpriteNode(imageNamed: "TutX")
        TutX.name = "myTutX"
        TutX.size = CGSizeMake(btnSizeW*1.2, btnSizeH*1.2)
        TutX.position = CGPointMake(self.frmWidth/6, self.frmHeight/3.0)
        TutX.alpha = 0.0
        
        var TutComboPoss = [
            [self.frmWidth/5.9, self.frmHeight/1.8],
            [self.frmWidth/4.75, self.frmHeight/3.5],
            [self.frmWidth/2.75, self.frmHeight/2.2],
            [self.frmWidth/2.5, self.frmHeight/3.8],
            [self.frmWidth/1.5, self.frmHeight/1.65],
            [self.frmWidth/1.35, self.frmHeight/2]]
        
        let TutFour = [
            SKAction.runBlock {
                let TutBallUp = [
                    SKAction.moveTo(CGPointMake(0, self.TutBallPlace.frame.size.height*0.25), duration: 0.6),
                    SKAction.moveTo(CGPointMake(0, self.TutBallPlace.frame.size.height*0.3), duration: 0.6)
                ]
                self.TutBall.runAction(SKAction.sequence(TutBallUp))
            },
            SKAction.waitForDuration(0.5),
            SKAction.runBlock {
                self.TutBallPlace.alpha = 0.3
                self.TutorialPage.enumerateChildNodesWithName("myTutBiji", usingBlock: { node, stop in
                    node.alpha = 0.5
                })
                self.TutWord.alpha = 1.0
                self.TutPaku.alpha = 1.0
            },
            SKAction.waitForDuration(0.5),
            SKAction.runBlock {
                self.TutorialPage.addChild(self.TutX)
                self.TutX.runAction(SKAction.repeatAction(SKAction.sequence(self.XFade), count: 3))
            },
            SKAction.waitForDuration(2.5),
            SKAction.runBlock {
                self.TutPaku.alpha = 0.5
                self.TutWord.runAction(SKAction.fadeOutWithDuration(0.5))
            },
            SKAction.waitForDuration(1.0),
            SKAction.runBlock {
                self.TutWord.texture = SKTexture(imageNamed: "TutWord05")
                self.TutWord.position = CGPointMake((self.frmWidth*0.5)-(self.btnSizeW*1.1), (self.frmHeight*0.5)+(self.btnSizeH*0.5))
                self.TutWord.runAction(SKAction.fadeInWithDuration(0.5))
                self.TutBomb.alpha = 1.0
                self.TutX.position = CGPointMake(self.frmWidth/1.6, self.frmHeight/2.35)
            },
            SKAction.waitForDuration(0.5),
            SKAction.runBlock {
                self.TutX.runAction(SKAction.repeatAction(SKAction.sequence(self.XFade), count: 3))
            },
            SKAction.waitForDuration(2.5),
            SKAction.runBlock {
                self.TutBomb.alpha = 0.5
                self.TutWord.runAction(SKAction.fadeOutWithDuration(0.5))
            },
            SKAction.waitForDuration(1.0),
            SKAction.runBlock {
                self.TutWord.position = CGPointMake((self.frmWidth*0.5)+(self.btnSizeW*1.3), (self.frmHeight*0.5)+(self.btnSizeH*2.2))
                self.TutWord.texture = SKTexture(imageNamed: "TutWord06")
                self.TutWord.runAction(SKAction.fadeInWithDuration(0.5))
                self.TutorialPage.enumerateChildNodesWithName("myTutBiji", usingBlock: { node, stop in
                    node.alpha = 1
                })
                var Value = 10
                for TutComboPos in TutComboPoss {
                    self.TutCombo = SKLabelNode(fontNamed: "Noteworthy-Bold")
                    self.TutCombo.text = "⭐️\(Value)"
                    self.TutCombo.fontSize = 36.0
                    self.TutCombo.fontColor = SKColor.yellowColor()
                    self.TutCombo.position = CGPointMake(TutComboPos[0]+(self.btnSizeW*0.3), TutComboPos[1]+(self.btnSizeH*0.4))
                    self.TutorialPage.addChild(self.TutCombo)
                    Value = Value + 10
                }
                self.outTutBtn.texture = SKTexture(imageNamed: "BtnPlay")
            }
        ]
        runAction(SKAction.sequence(TutFour))
    }
    
    func ConstructGameOverPage() {
        GameOverPage = SKSpriteNode(color: UIColor(white: 0, alpha: 0.65), size: self.frame.size)
        GameOverPage.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(GameOverPage)
        
        GOWord = SKSpriteNode(imageNamed: "GameOver")
        GOWord.size = CGSizeMake(frmWidth*0.19, frmHeight*0.19)
        GOWord.position = CGPointMake(0, btnSizeH*0.29)
        GameOverPage.addChild(GOWord)
        
        backBtn = SKSpriteNode(imageNamed: "BtnBackToMain") as SKSpriteNode
        backBtn.name = "BackBtn"
        backBtn.size = CGSizeMake(btnSizeW*5.2, btnSizeH*0.8)
        backBtn.position = CGPointMake(0-(frmWidth*0.5)+(btnSizeW*3.0), 0-(frmHeight*0.5)+(btnSizeH*0.8))
        GameOverPage.addChild(backBtn)
        
        repBtn = SKSpriteNode(imageNamed: "BtnReplay") as SKSpriteNode
        repBtn.name = "RepBtn"
        repBtn.size = CGSizeMake(btnSizeW*4.4, btnSizeH*0.8)
        repBtn.position = CGPointMake(0+(frmWidth*0.5)-(btnSizeW*2.6), 0-(frmHeight*0.5)+(btnSizeH*0.8))
        GameOverPage.addChild(repBtn)
        
        GOscore = SKLabelNode(fontNamed: "Noteworthy-Bold")
        if TimePlaying == true {
            GOscore.text = "Time Challenge Score : \(scoreLabel.text)"
        } else {
            GOscore.text = "Your Score : \(scoreLabel.text)"
        }
        GOscore.fontSize = 45.0
        GOscore.fontColor = SKColor.whiteColor()
        GOscore.position = CGPointMake(0-(btnSizeW*0.5) ,(MainPage.frame.height/2)-(btnSizeH*0.7))
        GameOverPage.addChild(GOscore)
        
        GOShare = SKSpriteNode(imageNamed: "BtnShare")
        GOShare.size = CGSizeMake(btnSizeW*2.4, btnSizeH*0.9)
        GOShare.position = CGPointMake(frmWidth*0.39, (frmHeight*0.5)-(btnSizeH*0.7))
        GameOverPage.addChild(GOShare)
        
        GOFB = SKSpriteNode(imageNamed:  "BtnSFB")
        GOFB.name = "BtnSFB"
        GOFB.size = CGSizeMake(btnSizeW, btnSizeH)
        GOFB.position = CGPointMake(frmWidth*0.39, (frmHeight*0.5)-(btnSizeH*1.5))
        GameOverPage.addChild(GOFB)
    }
    
    func ConstructHighScorePage() {
        HighScorePage = SKSpriteNode(imageNamed: "SettingBG")
        HighScorePage.size = CGSizeMake(frmWidth, frmHeight)
        HighScorePage.position = CGPointMake(frmWidth*0.5, frmHeight*0.5)
        self.addChild(HighScorePage)
        
        var HSTag = SKSpriteNode(imageNamed: "HighScore")
        HSTag.size = CGSizeMake(btnSizeW*4.4, btnSizeH*0.8)
        HSTag.position = CGPointMake(0, (frmHeight*0.5)-(btnSizeH*0.5))
        HighScorePage.addChild(HSTag)
        
        outHSBtn = SKSpriteNode(imageNamed: "BtnNo") as SKSpriteNode
        outHSBtn.name = "OutHS"
        outHSBtn.size = CGSizeMake(btnSizeW*1.0, btnSizeH*1.0)
        outHSBtn.position = CGPointMake((frmWidth*0.5)-(btnSizeW*0.8), 0-(frmHeight*0.5)+(btnSizeH*0.8))
        HighScorePage.addChild(outHSBtn)
    }
    
    func StartGame() {
        BallContactCount = 0
        
        FirstPlay = true
        pauseBall = false
        Lose = false
        
        JumBiji = 0
        JumPaku = 0
        JumBoom = 0
        
        Score = 0
        Level = 0
        Combo = 0
        
        PickStat = false
        PakuTouch = true
        
        MaxBiji = BijiPakuBoom[0][0]
        MaxPaku = BijiPakuBoom[0][1]
        MaxBoom = BijiPakuBoom[0][2]
        
    }
    
    func CreateBiji() {
        var Idx:Int = Int(arc4random() % UInt32(Bijis[Level].count))
        var randX = UInt32((frmWidth-BallPlace.frame.size.width)-(btnSizeW*2))
        var randY = UInt32(frmHeight-(btnSizeH*2))
        var BijiPosX:CGFloat = CGFloat((arc4random() % randX)+UInt32(btnSizeW*0.5))
        var BijiPosY:CGFloat = CGFloat((arc4random() % randY)+UInt32(btnSizeH*0.5))
        Biji = SKSpriteNode(imageNamed: "\(Bijis[Level][Idx])")
        Biji.name = "myBiji"
        Biji.size = CGSizeMake(btnSizeW*0.85, btnSizeH*0.85)
        Biji.position = CGPointMake(BijiPosX+(btnSizeW/2), frmHeight)
        Biji.physicsBody = SKPhysicsBody(circleOfRadius: Biji.frame.size.height/2)
        Biji.physicsBody?.usesPreciseCollisionDetection = true
        Biji.physicsBody?.affectedByGravity = false
        Biji.physicsBody?.allowsRotation = false
        if JumBiji < MaxBiji {
            GamePlace.addChild(Biji)
            let DropBiji = [SKAction.runBlock {
                self.Biji.runAction(SKAction.moveTo(CGPointMake(BijiPosX, BijiPosY), duration: 0.3))
                }, SKAction.waitForDuration(0.3), SFXpop]
            runAction(SKAction.sequence(DropBiji))
            JumBiji = JumBiji + 1
        } else {
            stopAddBiji()
        }
    }
    
    func CreatePaku() {
        var randX = UInt32((frmWidth-BallPlace.frame.size.width)-(btnSizeW*2))
        var randY = UInt32(frmHeight-(btnSizeH*2))
        var PakuPosX:CGFloat = CGFloat((arc4random() % randX)+UInt32(btnSizeW*0.5))
        var PakuPosY:CGFloat = CGFloat((arc4random() % randY)+UInt32(btnSizeH*0.5))
        Paku = SKSpriteNode(imageNamed: "Paku")
        Paku.name = "myPaku"
        Paku.size = CGSizeMake(btnSizeW*0.85, btnSizeH*0.85)
        Paku.position = CGPointMake(PakuPosX+(btnSizeW/2), frmHeight)
        Paku.physicsBody = SKPhysicsBody(circleOfRadius: Biji.frame.size.height/2)
        Paku.physicsBody?.usesPreciseCollisionDetection = true
        Paku.physicsBody?.affectedByGravity = false
        Paku.physicsBody?.allowsRotation = false
        if JumPaku < MaxPaku {
            GamePlace.addChild(Paku)
            let DropPaku = [SKAction.runBlock {
                self.Paku.runAction(SKAction.scaleTo(self.PakuSize[self.Level], duration: 0.3));
                self.Paku.runAction(SKAction.moveTo(CGPointMake(PakuPosX, PakuPosY), duration: 0.3))}, SKAction.waitForDuration(0.3), SFXclink]
            runAction(SKAction.sequence(DropPaku))
            JumPaku = JumPaku + 1
        } else {
            stopAddPaku()
        }
        if FirstPaku == true && Tutorial == true {
            NSLog("First Paku Appear Tutorial")
            FirstPaku = false
        }
    }
    
    func CreateBoom() {
        var randX = UInt32((frmWidth-BallPlace.frame.size.width)-(btnSizeW*2))
        var randY = UInt32(frmHeight-(btnSizeH*2))
        var BoomPosX:CGFloat = CGFloat((arc4random() % randX)+UInt32(btnSizeW*0.5))
        var BoomPosY:CGFloat = CGFloat((arc4random() % randY)+UInt32(btnSizeH*0.5))
        Boom = SKSpriteNode(imageNamed: "Boom")
        Boom.name = "myBoom"
        Boom.size = CGSizeMake(btnSizeW*0.85, btnSizeH*0.85)
        Boom.position = CGPointMake(BoomPosX+(btnSizeW/2), frmHeight)
        Boom.physicsBody = SKPhysicsBody(circleOfRadius: Biji.frame.size.height/2)
        Boom.physicsBody?.usesPreciseCollisionDetection = true
        Boom.physicsBody?.affectedByGravity = false
        Boom.physicsBody?.allowsRotation = false
        if JumBoom < MaxBoom {
            GamePlace.addChild(Boom)
            let DropBoom = [SKAction.runBlock {
                self.Boom.runAction(SKAction.scaleTo(self.BoomSize[self.Level], duration: 0.3));
                self.Boom.runAction(SKAction.moveTo(CGPointMake(BoomPosX, BoomPosY), duration: 0.3))}, SKAction.waitForDuration(0.3), SFXclink]
            runAction(SKAction.sequence(DropBoom))
            JumBoom = JumBoom + 1
        } else {
            stopAddBoom()
        }
        if FirstBoom == true && Tutorial == true {
            NSLog("First Boom Appear Tutorial")
            FirstBoom = false
        }
    }
    
    
    func AddBiji() {
        TimerAddBiji = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("CreateBiji"), userInfo: nil, repeats: true)
    }
    
    func stopAddBiji() {
        if TimerAddBiji != nil {
            TimerAddBiji.invalidate()
        }
        TimerAddBiji = nil
    }
    
    func AddPaku() {
        TimerAddPaku = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("CreatePaku"), userInfo: nil, repeats: true)
    }
    
    func stopAddPaku() {
        if TimerAddPaku != nil {
            TimerAddPaku.invalidate()
        }
        TimerAddPaku = nil
    }
    
    func AddBoom() {
        TimerAddBoom = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("CreateBoom"), userInfo: nil, repeats: true)
    }
    
    func stopAddBoom() {
        if TimerAddBoom != nil {
            TimerAddBoom.invalidate()
        }
        TimerAddBoom = nil
    }
    
    func MoveBiji() {
        let BijiMove = [SKAction.runBlock {
            self.GamePlace.enumerateChildNodesWithName("myBiji", usingBlock: { node, stop in
                var randX = UInt32((self.frmWidth-self.BallPlace.frame.size.width)-self.btnSizeW*2)
                var randY = UInt32(self.frmHeight-(self.btnSizeH*2))
                var BijiPosX:CGFloat = CGFloat((arc4random() % randX)+UInt32(self.btnSizeW*0.5))
                var BijiPosY:CGFloat = CGFloat((arc4random() % randY)+UInt32(self.btnSizeH*0.5))
                var WaitDur:NSTimeInterval = Double(arc4random() % 10)*0.1
                var Durasi:NSTimeInterval = (Double(arc4random() % 10)*0.1)+0.8
                node.runAction(SKAction.sequence([SKAction.waitForDuration(Durasi), SKAction.moveTo(CGPointMake(BijiPosX, BijiPosY), duration: Durasi)]))
            })
            }]
        runAction(SKAction.sequence(BijiMove))
    }
    
    func MovePaku() {
        let PakuMove = [SKAction.runBlock {
            self.GamePlace.enumerateChildNodesWithName("myPaku", usingBlock: { node, stop in
                var randX = UInt32((self.frmWidth-self.BallPlace.frame.size.width)-self.btnSizeW*2)
                var randY = UInt32(self.frmHeight-(self.btnSizeH*2))
                var PakuPosX:CGFloat = CGFloat((arc4random() % randX)+UInt32(self.btnSizeW*0.5))
                var PakuPosY:CGFloat = CGFloat((arc4random() % randY)+UInt32(self.btnSizeH*0.5))
                var WaitDur:NSTimeInterval = Double(arc4random() % 10)*0.1
                var Durasi:NSTimeInterval = (Double(arc4random() % 10)*0.1)+0.8
                node.runAction(SKAction.sequence([SKAction.waitForDuration(Durasi), SKAction.moveTo(CGPointMake(PakuPosX, PakuPosY), duration: Durasi)]))
            })
            }]
        runAction(SKAction.sequence(PakuMove))
    }
    
    func MoveBoom() {
        let BoomMove = [SKAction.runBlock {
            self.GamePlace.enumerateChildNodesWithName("myBoom", usingBlock: { node, stop in
                var randX = UInt32((self.frmWidth-self.BallPlace.frame.size.width)-self.btnSizeW*2)
                var randY = UInt32(self.frmHeight-(self.btnSizeH*2))
                var BoomPosX:CGFloat = CGFloat((arc4random() % randX)+UInt32(self.btnSizeW*0.5))
                var BoomPosY:CGFloat = CGFloat((arc4random() % randY)+UInt32(self.btnSizeH*0.5))
                var WaitDur:NSTimeInterval = (Double(arc4random() % 10)*0.1)+0.2
                var Durasi:NSTimeInterval = (Double(arc4random() % 10)*0.1)+0.8
                node.runAction(SKAction.sequence([SKAction.waitForDuration(Durasi), SKAction.moveTo(CGPointMake(BoomPosX, BoomPosY), duration: Durasi)]))
            })
            }]
        runAction(SKAction.sequence(BoomMove))
    }
    
    func KenaPaku() {
        kenaPaku = SKSpriteNode(imageNamed: "KenaPaku")
        kenaPaku.name = "KenaPaku"
        kenaPaku.size = CGSizeMake(frmWidth*0.2, frmHeight*0.2)
        kenaPaku.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(kenaPaku)
        let PakuAct = [SKAction.runBlock {
            self.kenaPaku.runAction(SKAction.resizeByWidth((self.frmWidth*0.7)*0.8, height: (self.frmHeight*0.8)*0.8, duration: 0.4))
            }, SKAction.waitForDuration(0.8), SKAction.runBlock {
                self.kenaPaku.removeFromParent()
                self.PakuTouch = true
            }]
        runAction(SKAction.sequence(PakuAct))
    }
    
    func KenaBoom() {
        kenaBoom = SKSpriteNode(imageNamed: "KenaBoom")
        kenaBoom.size = CGSizeMake(frmWidth*0.2, frmHeight*0.2)
        kenaBoom.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(kenaBoom)
        let BoomAct = [SKAction.runBlock {
            self.kenaBoom.runAction(SKAction.resizeByWidth((self.frmWidth*0.7)*0.8, height: (self.frmHeight*0.8)*0.8, duration: 0.6))
            }, SKAction.waitForDuration(2.0), SKAction.runBlock {
                self.kenaBoom.removeFromParent();
                self.EndGame()
            }]
        runAction(SKAction.sequence(BoomAct))
    }
    
    func Jatoh() {
        stopAddBiji()
        stopAddPaku()
        stopAddBoom()
        runAction(SKAction.sequence(SFXowow))
        kenaJatoh = SKSpriteNode(imageNamed: "KenaJatoh")
        kenaJatoh.size = CGSizeMake(frmWidth*0.2, frmHeight*0.2)
        kenaJatoh.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(kenaJatoh)
        let JatohAct = [SKAction.runBlock {
            self.kenaJatoh.runAction(SKAction.resizeByWidth((self.frmWidth*0.7)*1.2, height: (self.frmHeight*0.8)*1.2, duration: 0.6))
            }, SKAction.waitForDuration(2.0), SKAction.runBlock {
                self.kenaJatoh.removeFromParent();
                self.EndGame()
            }]
        runAction(SKAction.sequence(JatohAct))
    }
    
    func EndGame() {
        MSCgameplay.stop()
        let LoseAct = [SKAction.runBlock {
            self.ConstructGameOverPage();
            self.GOWord.runAction(SKAction.resizeByWidth(self.frmWidth*0.7, height: self.frmHeight*0.8, duration: 2))
            }]
        runAction(SKAction.sequence(LoseAct))
        MSCgameover.play()
        pauseBtn.removeFromParent()
        if GameTimer != nil {
            GameTimer.invalidate()
        }
    }
    
    func addBallSwipe() {
        let swipeBall:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleBallSwipe:")
        swipeBall.direction = .Up
        self.view?.addGestureRecognizer(swipeBall)
    }
    
    func emitLevel() {
        let burstEmitter = SKEmitterNode()
        burstEmitter.particleTexture = sparkLove
        burstEmitter.position = CGPointMake(frmWidth/2, btnSizeH)
        burstEmitter.particleBirthRate = 1500
        burstEmitter.numParticlesToEmit = 4000
        burstEmitter.particleLifetime = 0.5
        burstEmitter.particleSpeed = 400.0
        burstEmitter.xAcceleration = 0
        burstEmitter.yAcceleration = frmHeight
        burstEmitter.particleLifetimeRange = 0.5
        burstEmitter.particlePositionRange = CGVectorMake(frmWidth, frmHeight)
        burstEmitter.particleRotationRange = 360
        burstEmitter.particleScaleRange = 5.0
        
        burstEmitter.particleColorBlendFactor = 0.5
        burstEmitter.particleBlendMode = SKBlendMode.Add
        
        GamePlace.addChild(burstEmitter)
    }
    
    func emitTouchedNode(Xpose:CGFloat!, Ypose:CGFloat!, Black:Bool) {
        let burstEmitter = SKEmitterNode()
        burstEmitter.particleTexture = sparkSmoke
        burstEmitter.position = CGPointMake(Xpose, Ypose)
        burstEmitter.particleBirthRate = 50
        burstEmitter.numParticlesToEmit = 50
        burstEmitter.particleLifetime = 0.15
        burstEmitter.particleSpeed = 50.0
        burstEmitter.xAcceleration = 0
        burstEmitter.yAcceleration = btnSizeH
        burstEmitter.particleLifetimeRange = 0.05
        burstEmitter.particlePositionRange = CGVectorMake(btnSizeW*0.6, btnSizeH*0.6)
        burstEmitter.particleRotationRange = 360
        burstEmitter.particleScaleRange = 0.5
        
        burstEmitter.particleColorSequence = nil
        burstEmitter.particleColorBlendFactor = 1.0
        burstEmitter.particleBlendMode = SKBlendMode.Screen
        if Black == true {
            burstEmitter.particleColor = SKColor.grayColor()
        } else {
            burstEmitter.particleColor = SKColor.whiteColor()
        }
        
        GamePlace.addChild(burstEmitter)
    }
    
    func ComboLabel(Xpose:CGFloat!, Ypose:CGFloat!, Value:Int!) {
        ComboStatShad = SKLabelNode(fontNamed: "Noteworthy-Bold")
        if TimePlaying == true {
            ComboStatShad.text = "⌚️\(Value)"
        } else {
            ComboStatShad.text = "⭐️\(Value)"
        }
        ComboStatShad.name = "ComboLabel"
        ComboStatShad.fontSize = 36
        ComboStatShad.fontColor = SKColor.brownColor()
        ComboStatShad.position = CGPointMake(Xpose, Ypose)
        
        ComboStat = SKLabelNode(fontNamed: "Noteworthy-Bold")
        if TimePlaying == true {
            ComboStat.text = "⌚️\(Value)"
        } else {
            ComboStat.text = "⭐️\(Value)"
        }
        ComboStat.fontSize = 36.0
        ComboStat.fontColor = SKColor.yellowColor()
        ComboStat.position = CGPointMake(-2,4)
        
        let RemComboAni = [SKAction.runBlock {
            self.GamePlace.enumerateChildNodesWithName("ComboLabel", usingBlock: { node, stop in
                node.removeFromParent()
            })
            }]
        
        let MakeComboStat = [SKAction.runBlock {
            self.GamePlace.addChild(self.ComboStatShad);
            self.ComboStatShad.addChild(self.ComboStat);
            self.ComboStatShad.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), RemComboAni]))
            }
        ]
        runAction(SKAction.sequence(MakeComboStat))
        runAction(SKAction.sequence(SFXcombo))
    }
    
    func createSlider(PosY:CGFloat!) {
        if iosV < 8.0 {
            MusicVol = UISlider(frame: CGRectMake((self.view?.frame.height)!*0.3, (self.view?.frame.width)!*PosY, (self.view?.frame.height)!*0.4, (self.view?.frame.width)!*0.05))
        } else {
            MusicVol = UISlider(frame: CGRectMake((self.view?.frame.width)!*0.3, (self.view?.frame.height)!*PosY, (self.view?.frame.width)!*0.4, (self.view?.frame.height)!*0.05))
        }
        MusicVol.backgroundColor = UIColor.clearColor()
        MusicVol.minimumValue = 0.0
        MusicVol.maximumValue = 1.0
        MusicVol.value = MSCmainpage.volume
        MusicVol.continuous = true
        MusicVol.setThumbImage(UIImage(named: "Music"), forState: UIControlState.Normal)
        self.view?.addSubview(MusicVol)
        MusicVol.addTarget(self, action: "MusicVolumeDidChange:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func MusicVolumeDidChange(slider: UISlider) {
        MSCmainpage.volume = MusicVol.value
        MSCgameplay.volume = MusicVol.value
        MSCgameover.volume = MusicVol.value
    }
    
    func removeSlider() {
        MusicVol.removeFromSuperview()
    }
    
    func createSwitch() {
        TutLabel = SKSpriteNode(imageNamed: "Tutorial")
        TutLabel.size = CGSizeMake(btnSizeW*3.5, btnSizeH*0.9)
        TutLabel.position = CGPointMake(frmWidth*0.425, frmHeight*0.53)
        self.addChild(TutLabel)
        if iosV < 8.0 {
            TutSwitch = UISwitch(frame: CGRectMake((self.view?.frame.height)!*0.6, (self.view?.frame.width)!*0.43, 0, 0))
        } else {
            TutSwitch = UISwitch(frame: CGRectMake((self.view?.frame.width)!*0.6, (self.view?.frame.height)!*0.43, 0, 0))
        }
        TutSwitch.setOn(Tutorial, animated: false)
        self.view?.addSubview(TutSwitch)
        TutSwitch.addTarget(self, action: "TutDidChange:", forControlEvents: UIControlEvents.ValueChanged)
        
        FlipLabel = SKSpriteNode(imageNamed: "FlipLabel")
        FlipLabel.size = CGSizeMake(btnSizeW*2.8, btnSizeH*0.82)
        FlipLabel.position = CGPointMake(frmWidth*0.425, frmHeight*0.38)
        self.addChild(FlipLabel)
        if iosV < 8.0 {
            FlipSwitch = UISwitch(frame: CGRectMake((self.view?.frame.height)!*0.6, (self.view?.frame.width)!*0.58, 0, 0))
        } else {
            FlipSwitch = UISwitch(frame: CGRectMake((self.view?.frame.width)!*0.6, (self.view?.frame.height)!*0.58, 0, 0))
        }
        FlipSwitch.setOn(FlipGameStat, animated: false)
        self.view?.addSubview(FlipSwitch)
        FlipSwitch.addTarget(self, action: "FlipDidChange:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func TutDidChange(sender: UISwitch) {
        if TutSwitch.on {
            Tutorial = true
            FirstPaku = true
            FirstBoom = true
        } else {
            Tutorial = false
            FirstPaku = false
            FirstBoom = false
        }
    }
    
    func FlipDidChange(sender: UISwitch) {
        if FlipSwitch.on {
            NSLog("Flip On")
            FlipGameStat = true
        } else {
            NSLog("Flip Off")
            FlipGameStat = false
        }
    }
    
    func removeSwitch() {
        TutSwitch.removeFromSuperview()
        TutLabel.removeFromParent()
        FlipSwitch.removeFromSuperview()
        FlipLabel.removeFromParent()
    }
    
    func createTutChk() {
        TutChkLabel = SKSpriteNode(imageNamed: "ChkLabel")
        TutChkLabel.size = CGSizeMake(btnSizeW*5, btnSizeH*0.6)
        TutChkLabel.position = CGPointMake(frmWidth/2, btnSizeH*0.6)
        TutorialPage.addChild(TutChkLabel)
        TutChkBtn = SKSpriteNode(imageNamed: "ChkNo")
        TutChkBtn.name = "TutChkBtn"
        TutChkBtn.size = CGSizeMake(btnSizeW*0.6, btnSizeH*0.6)
        TutChkBtn.position = CGPointMake((frmWidth/2)-(btnSizeW*3) , btnSizeH*0.6)
        TutorialPage.addChild(TutChkBtn)
        ChkStat = false
    }
    
    func ChkChange() {
        if ChkStat == true {
            TutChkBtn.texture = SKTexture(imageNamed: "ChkNo")
            Tutorial = true
            FirstPaku = true
            FirstBoom = true
            ChkStat = false
        } else {
            TutChkBtn.texture = SKTexture(imageNamed: "ChkYes")
            Tutorial = false
            FirstPaku = false
            FirstBoom = false
            ChkStat = true
        }
    }
    
    func FlipGame() {
        scoreTitleShad.xScale = -1.0
        scoreLabelShad.xScale = -1.0
        GamePage.xScale = -1.0
        GamePage.position.x = frmWidth
        GamePlace.xScale = -1.0
        GamePlace.anchorPoint.x = 0
        GamePlace.position.x = frmWidth - BallPlace.frame.size.width - (btnSizeW/4)
        if TimePlaying == true {
            timerLabelShad.xScale = -1.0
        }
    }
    
    func UnFlipGame() {
        scoreTitleShad.xScale = 1.0
        scoreLabelShad.xScale = 1.0
        GamePage.xScale = 1.0
        GamePage.position.x = 0
        GamePlace.xScale = 1.0
        GamePlace.anchorPoint.x = 0
        GamePlace.position.x = btnSizeW/4
        if TimePlaying == true {
            timerLabelShad.xScale = 1.0
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyB.node?.name == Ball.name {
            Combo = 0
            BallContactCount = BallContactCount + 1
            let SwipeIndicator = [SKAction.waitForDuration(0.05),
                SKAction.runBlock { self.BallPlace.texture = SKTexture(imageNamed: "BallPlaceArrow") },
                SKAction.waitForDuration(1),
                SKAction.runBlock { self.BallPlace.texture = SKTexture(imageNamed: "BallPlace") }
            ]
            if BallContactCount > 1 {
                if BallContactCount == 2 {
                    Ball.texture = SKTexture(imageNamed: "\(Balls[Level])c")
                    Lose = true
                    Jatoh()
                }
                PickStat = false
            } else {
                runAction(SKAction.sequence(SFXboing))
                runAction(SKAction.sequence(SwipeIndicator))
            }
        }
    }
    
    func AddTimer() {
        if GameTimer != nil {
            GameTimer.invalidate()
        }
        TimeNow = 60
        timerLabelShad = SKLabelNode(fontNamed: "Noteworthy-Bold")
        timerLabelShad.text = "01:00"
        timerLabelShad.fontSize = 40.0
        timerLabelShad.fontColor = SKColor.blackColor()
        timerLabelShad.position = CGPointMake(frmWidth*0.65, frmHeight-(btnSizeH*0.8))
        GamePage.addChild(timerLabelShad)
        timerLabel = SKLabelNode(fontNamed: "Noteworthy-Bold")
        timerLabel.text = "01:00"
        timerLabel.fontSize = 40.0
        timerLabel.fontColor = SKColor.whiteColor()
        timerLabel.position = CGPointMake(-2,4)
        timerLabelShad.addChild(timerLabel)
    }
    
    func startTimer() {
        GameTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("UpdateTimer"), userInfo: nil, repeats: true)
    }
    
    func UpdateTimer() {
        var Menit:Int = (TimeNow % 3600)/60
        var Detik:Int = (TimeNow % 3600) % 60
        var showMenit:String!
        var showDetik:String!
        if Menit <= 9 { showMenit = "0\(Menit)" } else { showMenit = "\(Menit)" }
        if Detik <= 9 { showDetik = "0\(Detik)" } else { showDetik = "\(Detik)" }
        timerLabelShad.text = "\(showMenit):\(showDetik)"
        timerLabel.text = "\(showMenit):\(showDetik)"
        TimeNow = TimeNow - 1
        if TimeNow < 5 {
            timerLabelShad.runAction(SKAction.sequence(Shake))
        }
        if TimeNow < 0 {
            if GameTimer != nil {
                GameTimer.invalidate()
            }
            TimeOut()
        }
    }
    
    func TimeOut() {
        stopAddBiji()
        stopAddPaku()
        stopAddBoom()
        runAction(SKAction.sequence(SFXowow))
        kenaOut = SKSpriteNode(imageNamed: "TimesUp")
        kenaOut.size = CGSizeMake(frmWidth*0.2, frmHeight*0.2)
        kenaOut.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(kenaOut)
        let OutAct = [SKAction.runBlock {
            self.kenaOut.runAction(SKAction.resizeByWidth((self.frmWidth*0.7)*1.2, height: (self.frmHeight*0.8)*1.2, duration: 0.6))
            }, SKAction.waitForDuration(2.0), SKAction.runBlock {
                self.kenaOut.removeFromParent();
                self.Lose = true
                self.PickStat = false
                self.Ball.physicsBody?.velocity = CGVectorMake(0, 0)
                self.Ball.physicsBody?.affectedByGravity = false
                self.EndGame()
            }]
        runAction(SKAction.sequence(OutAct))
    }
    
    func handleError(call:FBAppCall?,result:[NSObject : AnyObject]?,errors:NSError?){
        if(errors != nil){
            println(errors?.description);
        }else{
            println(result);
        }
    }
    
    func handleErrors(result:FBWebDialogResult?,resultURL:NSURL?,errors:NSError?){
        if(errors != nil){
            println(errors?.description);
        }else{
            if(result == FBWebDialogResult.DialogNotCompleted ){
                println("user cancel");
            }else{
                println("very good job")
            }
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
