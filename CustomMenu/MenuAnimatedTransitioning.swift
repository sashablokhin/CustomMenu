//
//  MenuTransitionManager.swift
//  CustomMenu
//
//  Created by Alexander Blokhin on 30.12.15.
//  Copyright © 2015 Alexander Blokhin. All rights reserved.
//

import UIKit

class MenuAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {

    private var presenting = false
    
    // MARK: - UIViewControllerAnimatedTransitioning 
    
    // animate a change from one viewcontroller to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView()
        
        // create a tuple of our screens
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        // assign references to our menu view controller and the 'bottom' view controller from the tuple
        // remember that our menuViewController will alternate between the from and to view controller depending if we're presenting or dismissing
        let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let bottomView = bottomViewController.view
        
        if (self.presenting) {
            self.offStageMenuController(menuViewController)
        }
        
        // add the both views to our view controller
        container?.addSubview(bottomView)
        container?.addSubview(menuView)
        
        let duration = self.transitionDuration(transitionContext)
        
        // perform the animation!
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
                if (self.presenting) {
                    // fade in
                    self.onStageMenuController(menuViewController)
                }
                else {
                    // fade out
                    self.offStageMenuController(menuViewController)
                }
            
            }, completion: { finished in
                
                // tell our transitionContext object that we've finished animating
                transitionContext.completeTransition(true)
                
                // bug: we have to manually add our 'to view' back 
                UIApplication.sharedApplication().keyWindow?.addSubview(screens.to.view)
        })
    }
    
    // return how many seconds the transiton animation will take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    // MARK: - Supporting functions
    
    func offStageMenuController(menuViewController: MenuViewController) {
        menuViewController.view.alpha = 0
        
        // setup parameters for 2D transitions for animations
        let topRowOffset  :CGFloat = 300
        let middleRowOffset :CGFloat = 150
        let bottomRowOffset  :CGFloat = 50
        
        menuViewController.cameraImageView.transform = self.offStage(-topRowOffset)
        menuViewController.cameraLabel.transform = self.offStage(-topRowOffset)
        
        menuViewController.compassImageView.transform = self.offStage(topRowOffset)
        menuViewController.compassLabel.transform = self.offStage(topRowOffset)
        
        menuViewController.markerImageView.transform = self.offStage(-middleRowOffset)
        menuViewController.markerLabel.transform = self.offStage(-middleRowOffset)
        
        menuViewController.plannerImageView.transform = self.offStage(middleRowOffset)
        menuViewController.plannerLabel.transform = self.offStage(middleRowOffset)
        
        menuViewController.routeImageView.transform = self.offStage(-bottomRowOffset)
        menuViewController.routeLabel.transform = self.offStage(-bottomRowOffset)
        
        menuViewController.suitcaseImageView.transform = self.offStage(bottomRowOffset)
        menuViewController.suitcaseLabel.transform = self.offStage(bottomRowOffset)
    }
    
    func onStageMenuController(menuViewController: MenuViewController){
        // prepare menu to fade in
        menuViewController.view.alpha = 1
        
        menuViewController.cameraImageView.transform = CGAffineTransformIdentity
        menuViewController.cameraLabel.transform = CGAffineTransformIdentity
        
        menuViewController.compassImageView.transform = CGAffineTransformIdentity
        menuViewController.compassLabel.transform = CGAffineTransformIdentity
        
        menuViewController.markerImageView.transform = CGAffineTransformIdentity
        menuViewController.markerLabel.transform = CGAffineTransformIdentity
        
        menuViewController.plannerImageView.transform = CGAffineTransformIdentity
        menuViewController.plannerLabel.transform = CGAffineTransformIdentity
        
        menuViewController.routeImageView.transform = CGAffineTransformIdentity
        menuViewController.routeLabel.transform = CGAffineTransformIdentity
        
        menuViewController.suitcaseImageView.transform = CGAffineTransformIdentity
        menuViewController.suitcaseLabel.transform = CGAffineTransformIdentity
    }
    
    
    func offStage(amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransformMakeTranslation(amount, 0)
    }
    
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    // return the animataor when presenting a viewcontroller
    // rememeber that an animator (or animation controller) is any object that aheres to the UIViewControllerAnimatedTransitioning protocol
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}





