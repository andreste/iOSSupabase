import SwiftUI

struct AddCountryView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: AddCountryViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Country Name", text: $viewModel.name)
                        .textInputAutocapitalization(.words)
                }
                
                Section {
                    Toggle("I've visited this place", isOn: $viewModel.is_visited)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Add Country")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            do {
                                try await viewModel.saveCountry()
                                dismiss()
                            } catch {
                                // Error is handled by the view model
                            }
                        }
                    }
                    .disabled(viewModel.isLoading || viewModel.name.isEmpty)
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.1))
                }
            }
        }
    }
}
