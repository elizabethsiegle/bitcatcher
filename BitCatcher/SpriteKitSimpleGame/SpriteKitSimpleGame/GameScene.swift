//Cole Hudson

import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String){
  let url = NSBundle.mainBundle().URLForResource(
    filename, withExtension: nil)
  if (url == nil) {
    println("Could not find file: \(filename)")
    return
  }

  var error: NSError? = nil
  backgroundMusicPlayer = 
    AVAudioPlayer(contentsOfURL: url, error: &error)
  if backgroundMusicPlayer == nil {
    println("Could not create audio player: \(error!)")
    return
  }

  backgroundMusicPlayer.numberOfLoops = -1
  backgroundMusicPlayer.prepareToPlay()
  backgroundMusicPlayer.play()
}

import SpriteKit

func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
func sqrt(a: CGFloat) -> CGFloat {
  return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint
{
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
  
  func normalized() -> CGPoint {
    return self / length()
  }
}

struct PhysicsCategory {
  static let None      : UInt32 = 0
  static let All       : UInt32 = UInt32.max
  static let Monster   : UInt32 = 0b1       // 1
  static let Projectile: UInt32 = 0b10      // 2
}

class GameScene: SKScene, SKPhysicsContactDelegate
{
  
  let player = SKSpriteNode(imageNamed: "bitplayer.png")
  var monstersDestroyed = 0
  
  override func didMoveToView(view: SKView) {
  
    playBackgroundMusic("background-music-aac.caf")
  
    backgroundColor = SKColor.whiteColor()
    player.position = CGPoint(x: size.width/2, y: player.size.height * 2)
    addChild(player)
    
    physicsWorld.gravity = CGVectorMake(0, 0)
    physicsWorld.contactDelegate = self
    
    addMonster()
    
    runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.runBlock(addMonster),
        SKAction.waitForDuration(5.0)
      ])
    ))
    
  }
  
  func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }

  func random(#min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }

  func addMonster() {

    // Create sprite
    let monster = SKSpriteNode(imageNamed: "monster")
    monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.size)
    monster.physicsBody?.dynamic = true
    monster.physicsBody?.categoryBitMask = PhysicsCategory.Monster
    monster.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
    monster.physicsBody?.collisionBitMask = PhysicsCategory.None
    
    // Determine where to spawn the monster along the X axis
    let actualX = random(min: monster.size.width/2, max: size.width - (monster.size.width/2))
    
    // Position the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = CGPoint(x: actualX, y: size.height + monster.size.height/2)
    
    // Add the monster to the scene
    addChild(monster)
    
    // Determine speed of the monster
    let actualDuration = random(min: CGFloat(20.0), max: CGFloat(20.0))
    
    // Create the actions
    let actionMove = SKAction.moveTo(CGPoint(x: actualX, y: 0 - monster.size.height), duration: NSTimeInterval(actualDuration))
    
    let actionMoveDone = SKAction.removeFromParent()
    
    let loseAction = SKAction.runBlock()
    {
      let reveal = SKTransition.fadeWithDuration(0.5)
      let gameOverScene = GameOverScene(size: self.size, won: false)
      self.view?.presentScene(gameOverScene, transition: reveal)
    }
    monster.runAction(SKAction.sequence([actionMove, loseAction, actionMoveDone]))

  }
  
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
  {

    runAction(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))

    // 1 - Choose one of the touches to work with
    let touch = touches.first as! UITouch
    let touchLocation = touch.locationInNode(self)
    
    var point = CGPoint(x: touchLocation.x, y: player.position.y)
   
    //stuff
    var actualDuration:NSTimeInterval = 1.0
    var actionMove = SKAction.moveTo(point, duration: actualDuration)
    player.runAction(actionMove)
    
  }
  
  func projectileDidCollideWithMonster(projectile:SKSpriteNode, monster:SKSpriteNode) {
    println("Hit")
    projectile.removeFromParent()
    monster.removeFromParent()
    
    monstersDestroyed++
    if (monstersDestroyed > 30) {
      let reveal = SKTransition.flipHorizontalWithDuration(0.5)
      let gameOverScene = GameOverScene(size: self.size, won: true)
      self.view?.presentScene(gameOverScene, transition: reveal)
    }
    
  }
  
  func didBeginContact(contact: SKPhysicsContact)
  {

    // 1
    var firstBody: SKPhysicsBody
    var secondBody: SKPhysicsBody
    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
      firstBody = contact.bodyA
      secondBody = contact.bodyB
    } else {
      firstBody = contact.bodyB
      secondBody = contact.bodyA
    }
    
    // 2
    if ((firstBody.categoryBitMask & PhysicsCategory.Monster != 0) &&
        (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)) {
      projectileDidCollideWithMonster(firstBody.node as! SKSpriteNode, monster: secondBody.node as! SKSpriteNode)
    }
    
  }
  
}
