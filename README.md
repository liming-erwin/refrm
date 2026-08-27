# REFRM

An iOS app that coaches padel stroke technique in real time, using on-device 3D body-pose tracking to watch your form and count your reps.

## What it does

You pick a stroke to drill — forehand or backhand — set a target number of repetitions, and the app watches you through the camera. It tracks your body in 3D with Apple's Vision framework, measures joint angles as you swing, and counts reps as you complete them. Past sessions are kept in a training history so you can see what you've drilled.

Everything runs on-device. No footage leaves the phone.

## My role

Built with a team of 3 developers over roughly a week (30 April – 7 May 2026). I contributed 14 of the 26 commits and about 47% of the Swift in the final build.

**Owned end to end**

- **Training home** — the app's landing screen: stroke-module carousel, recent-training cards, and the navigation tying them together (`TrainingHomeView`, 100% mine)
- **Session configuration** — the pre-drill setup flow where you choose a rep target, including input validation and clamping (`SessionConfigurationView`, 100% mine)
- **Training state layer** — `TrainingHomeViewModel` (96% mine) and the `TrainingModule` / `TrainingSession` models behind it

**Not mine** — the Vision pose-detection layer (`VisionCoordinator`, `CameraViewController`, `CalibrationView`) and the training-history views were built by teammates. I integrated the training UI against it and contributed to `PlayingView`, the screen where the two meet.

I also handled branch integration for the carousel and camera work, merging PRs #4 and #5.

## Tech Stack

- Swift / SwiftUI
- [Vision](https://developer.apple.com/documentation/vision) — `VNHumanBodyPose3DObservation` for 3D joint tracking
- AVFoundation — camera capture
- MVVM, with `UIViewControllerRepresentable` bridging the camera layer into SwiftUI

## Getting Started

Requires a physical iPhone — the app needs a real camera, so the Simulator won't work.

1. Clone the repository:

   ```bash
   git clone https://github.com/liming-erwin/refrm.git
   cd refrm
   ```

2. Open `PadelPop.xcodeproj` in Xcode.
3. Set your own signing team under **Signing & Capabilities**.
4. Build and run on a connected iPhone, and grant camera access when prompted.

> The Xcode project is still named `PadelPop`, the working title from early development. The product was renamed REFRM later; the target and bundle identifier were never renamed to match.

## License

Released under the [MIT License](LICENSE).
