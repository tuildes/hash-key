enum SecureError: Error {
    case invalidInput(String)
    case leakedPassword
    case insecurePassword
    case urlError
}
