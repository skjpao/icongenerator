# iOS App Icon Generator

Simple macOS application that generates iOS app icons from SF Symbols.

## Features

- Generate 1024x1024 PNG icons from any SF Symbol
- Customizable icon colors
- Save icons to any location on your Mac
- Perfect for iOS app development

## Usage

1. Launch the application
2. The default symbol is "fork.knife.circle.fill". To use a different symbol, modify the code:

Image(systemName: "your.symbol.name")


3. To change the icon color, modify:

.foregroundColor(.yourColor)


4. Run the application in Xcode
5. Choose where to save your generated icon when prompted

## Requirements

- macOS 14.0 or later
- Xcode 15.0 or later

## Installation

1. Clone the repository

git clone https://github.com/skjpao/icongenerator.git


2. Open `icongenerator.xcodeproj` in Xcode
3. Build and run the project

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.