extension String {
    func localized() -> String {
        return NSLocalizedString(key: self, comment: "")
    }
}
