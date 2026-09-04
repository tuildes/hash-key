<img width="100%" src=".github/assets/banner.png" alt="HashingPass: Generate Secure Passwords with a interface mockup in right"/>

<p align="center">
  <i>A practical, open-source iOS app that generates secure passwords using hardware entropy (<code>SecRandomCopyBytes</code>).</i>
</p>

<p align="center">
  <a href="https://apps.apple.com/us/app/hashingpass-secure-passwords/id6761075213">
    <img src="https://img.shields.io/itunes/v/6761075213?label=App%20Store&logo=apple" alt="App Store Version">
  </a>
  <img src="https://img.shields.io/badge/Platform-iOS-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Swift-orange" alt="Swift">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License">
  <img src="https://img.shields.io/github/stars/tuildes/hashing-pass" alt="Github star">
</p>

## About

HashingPass is designed for speed and ultimate security. Instead of relying on standard pseudo-random number generators, it utilizes the device's cryptographically secure hardware noise via Apple's `SecRandomCopyBytes` API to ensure mathematically unpredictable passwords.

## Features

* **Cryptographically Secure:** Powered natively by `CryptoKit` by Apple
* **Fast & Practical:** Generate and copy complex passwords instantly to your clipboard.
* **Privacy First:** Zero tracking, zero data collection, and completely offline.

## License and Publication

The application is under the [MIT License](LICENSE) and published on the App Store.
