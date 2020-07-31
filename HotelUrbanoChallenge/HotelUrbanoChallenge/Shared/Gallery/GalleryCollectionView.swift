//
//  GalleryCollectionView.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 31/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class GalleryCollectionView: UICollectionView {
    
    var shouldScrollToNextCell: Bool = true
    
    var autoScrollTimer: Timer? = nil
    
    override func didMoveToWindow() {
        if self.window != nil {
            // Start auto scroll if collection become visible
            self.startAnimation()
        } else {
            // Stop auto scroll if collection become hidden
            self.stopAnimation()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // Pause auto scroll if the user is touching the collection
        self.shouldScrollToNextCell = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        // Resume auto scroll if some event cancels the user touch on collection
        self.shouldScrollToNextCell = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        // Resume auto scroll if the user stop touching the collection
        self.shouldScrollToNextCell = true
    }
    
}

extension GalleryCollectionView {
    
    // Start auto scroll
    private func startAnimation() {
        self.autoScrollTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
    }
    
    // Stop auto scroll
    private func stopAnimation() {
        self.autoScrollTimer?.invalidate()
    }
    
    // Scroll to next item
    @objc private func scrollToNextCell() {
        guard self.shouldScrollToNextCell else {
            return
        }
        
        guard self.numberOfItems(inSection: 0) > 1 else {
            return
        }
        
        guard var indexPath = self.indexPathsForVisibleItems.first else {
            return
        }
        
        indexPath.row += 1
        
        if indexPath.row >= self.numberOfItems(inSection: 0) {
            indexPath.row = 0
        }
        
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}
