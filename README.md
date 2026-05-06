<h1 align="center">
  HashKey
</h1>

<p align="center">
  <i>A practical, open-source iOS app that generates secure passwords using hardware entropy (<code>SecRandomCopyBytes</code>).</i>
</p>

<p align="center">
  <a href="https://apps.apple.com/us/app/hashkey-secure-passwords/id6761075213">
    <img src="https://img.shields.io/itunes/v/6761075213?label=App%20Store&logo=apple" alt="App Store Version">
  </a>
  <img src="https://img.shields.io/badge/Platform-iOS-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Swift-orange" alt="Swift">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License">
  <img src="https://img.shields.io/github/stars/tuildes/hash-key" alt="Github star">
</p>

## About

HashKey is designed for speed and ultimate security. Instead of relying on standard pseudo-random number generators, it utilizes the device's cryptographically secure hardware noise via Apple's `SecRandomCopyBytes` API to ensure mathematically unpredictable passwords.

<details open>
<summary>
  Screenshots
</summary>
<br />

<p align="center">
  <img width="49%" src=".github/assets/mockup.png" alt="HashKey Main Interface"/>
</p>
</details>

## Features

* **Cryptographically Secure:** Powered natively by `CryptoKit` by Apple
* **Fast & Practical:** Generate and copy complex passwords instantly to your clipboard.
* **Privacy First:** Zero tracking, zero data collection, and completely offline.

## License and Publication

The application is under the [MIT License](LICENSE) and published on the App Store.
