source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'
use_frameworks!
 
workspace 'R3PI-Exercise'
 
def shared_pods
 	pod 'Swinject', '2.0'
	pod 'SwinjectStoryboard', '1.1'
end
 
target 'ShoppingBasket' do
   	shared_pods
	project 'ShoppingBasket/ShoppingBasket.xcodeproj'
end

target 'ShoppingBasketTests' do
   	shared_pods
    project 'ShoppingBasket/ShoppingBasket.xcodeproj'
end
