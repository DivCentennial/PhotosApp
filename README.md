SwiftUI app that allows users to select photos from their camera or photo library, which will then be displayed in a horizontally scrolling layout at the bottom of the screen.



This is a simpler assignment than what I suggested it would be in class. There is no camera or Swift Package Manager component.  In a future assignment you will incorporate those elements into your code for this assignment.  The groups will be the same, so you can decide how to split-up the work.



Your solution will closely resemble the class demo, except more advanced logic is needed when dealing with multiple photos.

https://github.com/cenkbilgen/mapd724-w25/blob/main/Module9-Photos/PhotosSample.swift



### Requirements:



1. **Add Photo Button**:

  - Design a button labeled "Add Photo" that is on top of a fullscreen background LinearGradient view that goes evenly from orange to blue to red from the topLeading corner to the bottomTrailing corner.

  - When tapped, the button should bring up the photo picker using the SwiftUI modifier: `.photosPicker(isPresented: , ...)`. Do not create a `PhotosPicker` View directly.



  - **Selection Criteria**:

   - The user can select multiple photos, with a maximum limit of **5**.

   - Ensure that only photos can be selected; videos and live photos should be filtered out.



2. **Display Selected Photos**:

  - The selected photos should be shown in a `HStack` contained within a horizontal `ScrollView` situated at the bottom of the screen.

  - The height of this `ScrollView` should be **1/5** of the total height of the scene.



### Important Notes:



1. **Retention of Selected Items**:

  - Unlike the demo provided in class, the selected photo items should **not** reset when the user closes the photo picker.



2. **Avoid UIKit**:

  - Do not use `UIImage` or any other components from UIKit. 



3. **Scrollable Photos Layout**:

  - It is preferable to overlay the scrolling selected photos instead of adding them to a `ZStack`.

  - Use the `.containerRelativeFrame` modifier to set the vertical size relative to the container, instead of using a `GeometryReader`.



4. **Photo Orientation**:

  - Do not worry about the correct orientation of the photos. You easily recognize when a photo is upside-down, a computer can't (ignoring AI). Handling orientation correctly is a complicated issue. Just display the photos as they are encoded.
