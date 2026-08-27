import SwiftUI

struct SessionConfigurationView: View {
    @Bindable var homeViewModel: TrainingHomeViewModel
    var padelViewModel: PadelViewModel
    @FocusState private var isKeyboardFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Input Reps
                HStack {
                    Text("Reps")
                        .font(.body)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    TextField("10", value: $homeViewModel.repetitionCount, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isKeyboardFocused)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.title3, design: .rounded).bold())
                        .foregroundColor(isKeyboardFocused ? .orange : .primary)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color(.systemGray6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(isKeyboardFocused ? Color.orange.opacity(0.5) : Color.clear, lineWidth: 2)
                                )
                        )
                        .frame(width: 120)
                        .onChange(of: homeViewModel.repetitionCount) { _, newValue in
                            if newValue > 200 {
                                homeViewModel.repetitionCount = 200
                            }
                        }
                }
                .padding(.horizontal, 16)
                
                // Start Button
                Button(action: {
                    startTrainingAction()
                }) {
                    Text("Start")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 232/255, green: 69/255, blue: 10/255))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .disabled(homeViewModel.selectedModuleId == nil)
                .opacity(homeViewModel.selectedModuleId == nil ? 0.4 : 1.0)
                .padding(.horizontal, 16)
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    // Spacer ini penting buat dorong tombol ke kanan
                    Spacer()
                    
                    Button("Done") {
                        validateAndDismiss()
                    }
                    .buttonStyle(.bordered) // Pake border biar gak terlalu "blok"
                    .tint(.orange)
                    .controlSize(.small) // Kecilin dikit biar gak nutupin field
                }
            }
            .padding(.bottom, isKeyboardFocused ? 60 : 0)
            .animation(.smooth(duration: 0.3), value: isKeyboardFocused)
        }
        .defaultScrollAnchor(.bottom)
    }

    // MARK: - Helper Functions
    
    private func validateAndDismiss() {
        if homeViewModel.repetitionCount < 1 {
            homeViewModel.repetitionCount = 1
        }
        isKeyboardFocused = false
    }
    
    private func startTrainingAction() {
        homeViewModel.startSession()
        if let module = homeViewModel.modules.first(where: { $0.id == homeViewModel.selectedModuleId }) {
            padelViewModel.startGame(with: PadelForm(name: module.name, description: module.category))
        } else {
            padelViewModel.startGame(with: PadelForm(name: "Forehand", description: "Technique"))
        }
    }
}
