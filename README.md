# Easy Convert
<img src="https://github.com/AndreaBot/Easy-Convert/assets/128467098/74f681bd-58ec-4ba9-9d5a-c12bf55982db" alt="1024" width="180">

Easy Convert is the very first app I built myself using SwiftUI and it part of the Day 19 Challenge of the 100 Days of SwiftUI course by Paul Hudson.

The goal for this project was to build a tool to let users convert various unit of measures, this was a good way to focus on learning the new framework as the app itself was very easy to build.

<img width="220" alt="Screenshot 2024-06-04 at 22 13 56" src="https://github.com/AndreaBot/Easy-Convert/assets/128467098/a285647f-80bb-4c78-a00b-3d9162025baa">  <img width="220" alt="Screenshot 2024-06-04 at 22 14 31" src="https://github.com/AndreaBot/Easy-Convert/assets/128467098/4f9ce3ea-a22c-4d52-bcee-0388e6626934">  <img width="220" alt="Screenshot 2024-06-04 at 22 15 08" src="https://github.com/AndreaBot/Easy-Convert/assets/128467098/60ecfed7-cc47-4715-9581-b3da933f3576">

A segmented picker at the top of the screen is used to select the unit category (lenghts, weights, temperatures), the user can then select which units they'd like to work with.
The unit conversion is taken care of by a String:Double dictionary within the ViewModel which stores the conversion factors for all possible unit conversions.

<img width="304" alt="Screenshot 2024-06-04 at 22 22 21" src="https://github.com/AndreaBot/Easy-Convert/assets/128467098/11ab4150-f2e4-41bb-abaa-c5857d8e33d3">
