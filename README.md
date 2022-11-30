![114](https://user-images.githubusercontent.com/52772674/196005816-7e7cb4c5-db16-4252-8f1e-382840a79644.png)


# podCapsule

podCapsule is an iOS application that uses ListenNotes API to enable users to discover and listen to podcasts. Users can choose their favorite categories and find the best podcasts for each category. Users can listen to streamed podcasts without downloading them and share them with others, and also can search for a specific episode or podcast. user is able to add podcasts or episodes to his favorites list and save it locally.

<p align="center">
<img src = https://github.com/mosliem/podCapsule/blob/main/Screenshots/mock.png>
</p>

## Demo

https://user-images.githubusercontent.com/52772674/195969837-aae240dc-89e2-4cbe-85f8-e172bbcb6142.mp4

## Built With
- VIPER Architecture Pattern 
- Xcode 12.4
- Swift 5.3 & UIKit
- AVFoundation
- Compositional layout
- Realm 
- Lottie-iOS



<h3> Don't forget Pods install </h3>

        pod install


<h3> Edit for SKCountryPicker Pod  </h3>

At CountryPickerController.swift in SKCountryPicker Pod add this protocol to get everything work well   

    public protocol CountryPickerDelegate: class {
          func didSelectCountry(_ country: Country)
    }
    
## Features 

- Discover best podcasts for any number of selected categories.
- View Podcast details with all streamed episodes.
- Listen to streamed podcasts and episodes without any need to download.
- Share any podcast or episode with its listening link.
- Search for podcast or episode by name, publisher or description.
- Add podcast or episode to favorites list and save podcasts locally.


## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.
  
<h3 align="left">Connect with me</h3>

 -  Mohamed Sliem - mohamedmostafa191299@gmail.com
 -  [Linkedin](https://www.linkedin.com/in/mohamed-sliem-662491172/)
