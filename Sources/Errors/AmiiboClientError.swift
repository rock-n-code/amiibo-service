public enum AmiiboClientError: Error {
    case responseCode(Int)
    case responseCodeNotFound
}
