# DRAuraButton

[![CI Status](http://img.shields.io/travis/Charles Thierry/DRAuraButton.svg?style=flat)](https://travis-ci.org/Charles Thierry/DRAuraButton)
[![Version](https://img.shields.io/cocoapods/v/DRAuraButton.svg?style=flat)](http://cocoapods.org/pods/DRAuraButton)
[![License](https://img.shields.io/cocoapods/l/DRAuraButton.svg?style=flat)](http://cocoapods.org/pods/DRAuraButton)
[![Platform](https://img.shields.io/cocoapods/p/DRAuraButton.svg?style=flat)](http://cocoapods.org/pods/DRAuraButton)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DRAuraButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DRAuraButton"
```

## About

DRAuraButton is a UIButton with a subview, that displays a rotating circle. Multiple configuration of stroke width, radius, stroke color can be dynamically specified and transitionned to.

#### Instantiate

Any storyboard button can be set to be a `DRAuraButton`. 

#### States

The button presents arbitrary states, defined by the developer.

A state is defined by a set of properties, stored in a `DRAuraConfiguration` object. Among those properties are the `ID` object. It serves as state identifier (for example in the  `DRAuraButton.currentState`). All states must have a different `ID`.

To create and add a new state, use the DRAuraButton `addAuraConfigurations:` method: 

```ObjC
[myButton addAuraConfigurations:^(DRAuraConfiguration *c) {
	c.ID = @"my State name";
	c.width = auraWidth;
	c.space = auraSpace;
	c.offset = auraOffset;
	c.step = auraStep;
	c.color = auraColor;
}];
```
To switch to that state, call `setCurrentState:` :

```ObjC
[myButton setCurrentState:@"my State name"];
```

The speed of rotation is customizable (`DRAuraConfiguration.step`, greater is faster), as well as the distance between the button and the circle (`DRAuraConfiguration.space` greater is closer), the stroke width (`DRAuraConfiguration.width` greater is wider) and the space between the top half and the bottom half (`DRAuraConfiguration.offset` greater is wider).

This project was done mainly to test the Core Animation framework -- it uses `CABasicAnimation`s to animates transition between states of the circle.

## License

DRAuraButton is available under the MIT license. See the LICENSE file for more info.
